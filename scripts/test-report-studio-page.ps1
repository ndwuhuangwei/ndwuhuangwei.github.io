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
    '早期流程片段',
    '以下展示一段早期流程片段，只覆盖从创建任务，经需求澄清、专家沙龙与逻辑规划，到进入报告生成的前半段；新功能的演示视频将陆续放出。',
    'The following is an early workflow excerpt. It covers only the first half of the journey—from task creation through requirement clarification, expert salon, and logic planning to the start of report generation. Walkthroughs of new features will be released progressively.',
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
    'explicit degradation',
    '现有视频是一段 **45.5 秒的早期流程片段**',
    'This is a **45.5-second early workflow excerpt**'
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
