$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pagePath = Join-Path $repoRoot '_pages\call-proxy-assistant.md'
$dataPath = Join-Path $repoRoot 'assets\data\callproxy-nlu-traces.json'
$scriptPath = Join-Path $repoRoot 'assets\js\callproxy-nlu-traces.js'

$page = Get-Content -LiteralPath $pagePath -Raw
$trace = Get-Content -LiteralPath $dataPath -Raw | ConvertFrom-Json
$script = Get-Content -LiteralPath $scriptPath -Raw
$turns = @($trace.cases | ForEach-Object { $_.turns })
$produced = @($turns | Where-Object schemaStatus -eq 'produced')
$skipped = @($turns | Where-Object schemaStatus -eq 'skipped')

function Assert-True([bool]$Condition, [string]$Message) {
  if (-not $Condition) { throw $Message }
}

Assert-True ($trace.schema -eq 'callproxy-nlu-trace-display-v1') 'Unexpected trace schema.'
Assert-True (@($trace.cases).Count -eq 8) 'Expected 8 cases.'
Assert-True ($turns.Count -eq 21) 'Expected 21 turns.'
Assert-True ($produced.Count -eq 17) 'Expected 17 model-produced schemas.'
Assert-True ($skipped.Count -eq 4) 'Expected 4 deterministic pre-NLU turns.'
Assert-True (@($turns | Where-Object { [string]::IsNullOrWhiteSpace($_.caller) }).Count -eq 0) 'Every turn needs caller text.'
Assert-True (@($turns | Where-Object { [string]::IsNullOrWhiteSpace($_.reply) }).Count -eq 0) 'Every turn needs an assistant reply.'
Assert-True (@($produced | Where-Object { [string]::IsNullOrWhiteSpace($_.raw) }).Count -eq 0) 'Produced turns need raw schema.'
Assert-True (@($skipped | Where-Object { $null -ne $_.raw }).Count -eq 0) 'Skipped turns must not invent schema.'

foreach ($turn in $produced) {
  try { $null = $turn.raw | ConvertFrom-Json }
  catch { throw "Invalid raw schema in displayed turn $($turn.n): $($_.Exception.Message)" }
}

foreach ($case in $trace.cases) {
  Assert-True ($page.Contains("data-case=`"$($case.id)`"")) "Missing page trigger for $($case.id)."
}

Assert-True (([regex]::Matches($page, 'class="cpa-trace-open"')).Count -eq 8) 'Expected exactly 8 trace buttons.'
Assert-True ($page.Contains('id="cpa-trace-dialog"')) 'Missing trace dialog.'
Assert-True ($page.Contains('/assets/js/callproxy-nlu-traces.js')) 'Trace script is not loaded by the page.'
Assert-True ($script.Contains('/assets/data/callproxy-nlu-traces.json')) 'Trace script does not load the trace data.'
Assert-True (-not $page.Contains('预置地址被全部否决')) 'Case 3 still claims every preset location was rejected.'

[pscustomobject]@{
  Cases = @($trace.cases).Count
  Turns = $turns.Count
  SchemaProduced = $produced.Count
  SchemaSkipped = $skipped.Count
  TraceButtons = ([regex]::Matches($page, 'class="cpa-trace-open"')).Count
  Status = 'PASS'
} | Format-List
