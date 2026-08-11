<#
.SYNOPSIS
  把「代接助手」交付包里的演示视频转成网页可直接播放的 H.264 MP4，并抽帧生成封面图。

.DESCRIPTION
  原始素材是 HEVC 编码的 .mov（手持相机实拍真机，带旋转元数据，实际显示为 1080x1920 竖屏）。
  HEVC 在多数浏览器里放不出来，必须转 H.264。

  编码口径（实测定档）：
    - case 演示  CRF 26 —— 与源肉眼无差
    - APP 总览   CRF 28 —— 时长 4'53"，压一档控制体积
    - 一律不放大：源已低于 1080 宽的（case 8）保持原分辨率
    - +faststart 让 moov 前置，边下边播

  隐私遮罩（2026-08-11 全片抽帧核查后加入）：
    APP 总览片 263.0–281.8 s 的通讯录演示段（选择联系人 / 黑名单添加）会露出
    真实联系人姓名与手机号，该窗口做整帧高斯模糊并叠加说明字幕，音轨不受影响。
    通过条目上的 mask 字段声明，勿删。

.PARAMETER SourceDir
  交付包里的「演示视频」目录。不写死在脚本里，避免把交付包路径带进仓库。

.EXAMPLE
  pwsh -File scripts/transcode-callproxy.ps1 -SourceDir 'X:\<交付包>\演示视频'
#>
param(
  [Parameter(Mandatory = $true)][string]$SourceDir,
  [string]$FFmpeg    = 'ffmpeg',
  [string]$FFprobe   = 'ffprobe',
  [string]$VideoOut  = (Join-Path $PSScriptRoot '..\files\callproxy'),
  [string]$PosterOut = (Join-Path $PSScriptRoot '..\images\callproxy')
)

$ErrorActionPreference = 'Stop'

# src      : 交付包内的文件名
# slug     : 输出名（纯 ASCII，避免 URL 转义）
# crf      : x264 质量档
# posterAt : 抽封面的时间点（秒），取对话已经铺开的位置
# mask     : 可选，隐私遮罩窗口（整帧模糊 + 说明字幕），见文件头「隐私遮罩」说明
$items = @(
  @{ src = 'APP整体介绍.mov';                                slug = 'intro';                    crf = 28; posterAt = 30
     mask = @{ from = 263.0; to = 281.8; note = '已隐去通讯录隐私信息' } }
  @{ src = 'case 1-正常外卖对话.mov';                        slug = 'case1-takeout';            crf = 26; posterAt = 22 }
  @{ src = 'case 2-与快递员多轮对话-持续提供预置地址.mov';   slug = 'case2-courier-address';    crf = 26; posterAt = 40 }
  @{ src = 'case 3-快递员否定所有预置地址-自动转接机主.mov'; slug = 'case3-address-exhausted';  crf = 26; posterAt = 45 }
  @{ src = 'case 4-骑手找不到地址-自动转接机主.mov';         slug = 'case4-rider-lost';         crf = 26; posterAt = 33 }
  @{ src = 'case 5-威胁辱骂场景.mov';                        slug = 'case5-abuse';              crf = 26; posterAt = 36 }
  @{ src = 'case 6-来电者强调有事要转告机主.mov';            slug = 'case6-message-relay';      crf = 26; posterAt = 38 }
  @{ src = 'case 7-物业有多件事要转告机主.mov';              slug = 'case7-property-multi';     crf = 26; posterAt = 50 }
  @{ src = 'case 8-同事来电-先告知信息再要求转接.mp4';       slug = 'case8-colleague-transfer'; crf = 26; posterAt = 40 }
)

New-Item -ItemType Directory -Force -Path $VideoOut, $PosterOut | Out-Null

$total = $items.Count
$i = 0
foreach ($it in $items) {
  $i++
  $in = Join-Path $SourceDir $it.src
  if (-not (Test-Path -LiteralPath $in)) { throw "找不到源文件: $in" }

  $mp4 = Join-Path $VideoOut  ($it.slug + '.mp4')
  $jpg = Join-Path $PosterOut ($it.slug + '.jpg')

  Write-Host "[$i/$total] $($it.slug)  (CRF $($it.crf))  <- $($it.src)"

  # scale='min(1080,iw)':-2 —— 旋转由 ffmpeg 自动应用在 scale 之前，iw 已是竖屏宽度；
  # min() 保证只降不升，case 8 原生 720 宽不会被拉伸。
  $vf = "scale='min(1080,iw)':-2"
  if ($it.mask) {
    # 整帧高斯模糊（sigma 45 在 1080 宽下文字完全不可恢复）+ 居中说明字幕。
    # 字幕文本经临时 UTF-8 文件传入，避免命令行编码问题。
    $noteFile = Join-Path ([System.IO.Path]::GetTempPath()) "callproxy-mask-$($it.slug).txt"
    [System.IO.File]::WriteAllText($noteFile, $it.mask.note, [System.Text.UTF8Encoding]::new($false))
    $nf  = ($noteFile -replace '\\', '/') -replace ':', '\:'
    $win = "between(t,$($it.mask.from),$($it.mask.to))"
    $vf += ",gblur=sigma=45:enable='$win'"
    $vf += ",drawtext=fontfile='C\:/Windows/Fonts/msyh.ttc':textfile='$nf':fontsize=54:fontcolor=white:box=1:boxcolor=black@0.45:boxborderw=24:x=(w-text_w)/2:y=(h-text_h)/2:enable='$win'"
  }
  & $FFmpeg -y -v error -stats -i $in `
      -vf $vf `
      -c:v libx264 -preset slow -crf $it.crf -pix_fmt yuv420p `
      -c:a aac -b:a 96k -movflags +faststart `
      $mp4
  if ($LASTEXITCODE -ne 0) { throw "转码失败: $($it.src)" }

  # 封面从转码结果抽，保证和播放首帧同源
  & $FFmpeg -y -v error -ss $it.posterAt -i $mp4 -frames:v 1 `
      -vf "scale='min(540,iw)':-2" -q:v 4 $jpg
  if ($LASTEXITCODE -ne 0) { throw "抽封面失败: $($it.slug)" }
}

Write-Host "`n=== 产物 ==="
$sum = 0
foreach ($f in (Get-ChildItem $VideoOut -Filter *.mp4 | Sort-Object Name)) {
  $mb = [math]::Round($f.Length / 1MB, 2); $sum += $mb
  $dim = (& $FFprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 $f.FullName).Trim().TrimEnd(',')
  '{0,-32} {1,8} MB  {2}' -f $f.Name, $mb, $dim
}
'{0,-32} {1,8} MB' -f '视频合计', [math]::Round($sum, 2)
$pmb = [math]::Round((Get-ChildItem $PosterOut -Filter *.jpg | Measure-Object Length -Sum).Sum / 1MB, 2)
'{0,-32} {1,8} MB' -f '封面合计', $pmb
