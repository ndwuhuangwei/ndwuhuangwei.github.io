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
    '45.5 秒',
    '早期流程片段',
    '视频尚未展示',
    'Markdown / DOCX'
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
    'explicit degradation'
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

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    exit 1
}

Write-Host 'Report Studio page contract passed.'
