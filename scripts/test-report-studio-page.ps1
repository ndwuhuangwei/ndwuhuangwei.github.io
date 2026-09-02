$ErrorActionPreference = 'Stop'

$pagePath = Join-Path $PSScriptRoot '..\_pages\report-studio.md'
$content = Get-Content -Raw -LiteralPath $pagePath

$required = @(
    'https://deepx.acemap.info/',
    'https://deepx.acemap.info/report-studio/',
    '内测阶段实行邀请制',
    '只有被邀请的专家才能使用',
    'mailto:wuhuangwei@sjtu.edu.cn',
    '地球科学地平线',
    '合作内测',
    'LangGraph',
    'Agentic RAG',
    'BM25',
    'BGE-M3',
    'RRF',
    'Cross-Encoder',
    'Tavily',
    'DeepSeek',
    'OpenAI-compatible',
    'Human-in-the-loop (HITL)',
    'https://www.acemap.info/',
    '基于 LangGraph 架构开发',
    '数据图表生成工具',
    '编辑助手 Agent',
    'built on LangGraph',
    'chart-generation tools',
    'editing-assistant agent',
    'Markdown / DOCX',
    '四段实录，按产品旅程排列',
    'Four screen recordings, ordered along the product journey',
    '中文字幕已烧录',
    'Chinese subtitles are burned into the picture',
    'rs-grid',
    'rs-card-title',
    '/images/report-studio/v4-library.jpg',
    '/images/report-studio/v2-salon.jpg',
    '/images/report-studio/v3-revise.jpg',
    '/images/report-studio/v1-agent.jpg',
    '文献知识库',
    'Literature knowledge base',
    '需求澄清与专家沙龙',
    'Clarification and expert salon',
    '大纲审阅与正文写作',
    'Outline review and drafting',
    '成稿后的编辑 Agent',
    'Post-draft editing agent'
)

$forbidden = @(
    '系统总览',
    'System Overview',
    'rs-overview',
    'overview.png',
    'Markdown / PDF / DOCX',
    '覆盖已上线主流程',
    'covers the shipped main pipeline',
    'deepx.acemap.cn',
    '{XXX, 完整英文全称}',
    '{给出链接}',
    '和Tavily',
    '同时， 编辑助手',
    'explicit degradation',
    '现有视频是一段 **45.5 秒的早期流程片段**',
    'This is a **45.5-second early workflow excerpt**',
    'report-agent-intro',
    'rs-intro',
    '早期流程片段',
    '视频尚未展示',
    '更多新功能待展示',
    '45.5',
    'rs-pending',
    '这四段尚未覆盖',
    'Not yet covered by these four videos'
)

$failures = [System.Collections.Generic.List[string]]::new()
foreach ($needle in $required) {
    if (-not $content.Contains($needle)) {
        $failures.Add("Missing required content: $needle")
    }
}
foreach ($needle in $forbidden) {
    if ($content.Contains($needle)) {
        $failures.Add("Forbidden stale content remains: $needle")
    }
}

# 四支演示视频：必须齐全、按 v4-library -> v2-salon -> v3-revise -> v1-agent 排列、且都不预加载
$demoOrder = @('v4-library.mp4', 'v2-salon.mp4', 'v3-revise.mp4', 'v1-agent.mp4')
$positions = @($demoOrder | ForEach-Object { $content.IndexOf("/files/report-studio/$_") })
if ($positions -contains -1) {
    $failures.Add('Missing one of the four demo videos under /files/report-studio/.')
} elseif ((($positions | Sort-Object) -join ',') -ne ($positions -join ',')) {
    $failures.Add('Demo videos must appear in order: v4-library, v2-salon, v3-revise, v1-agent.')
}
if ([regex]::Matches($content, [regex]::Escape('preload="none"')).Count -lt 4) {
    $failures.Add('Every demo <video> must keep preload="none".')
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    exit 1
}

Write-Host 'Report Studio page contract passed.'
