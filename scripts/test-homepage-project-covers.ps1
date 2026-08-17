$ErrorActionPreference = 'Stop'

$pagePath = Join-Path $PSScriptRoot '..\_pages\about.md'
$content = Get-Content -Raw -LiteralPath $pagePath

$requiredAssets = @(
    'images\callproxy\project-cover-v1.webp',
    'images\report-studio\project-cover-v1.webp'
)

$failures = [System.Collections.Generic.List[string]]::new()

foreach ($asset in $requiredAssets) {
    $assetPath = Join-Path $PSScriptRoot "..\$asset"
    if (-not (Test-Path -LiteralPath $assetPath -PathType Leaf)) {
        $failures.Add("Missing project cover asset: $asset")
    }
}

foreach ($source in @(
    '/images/callproxy/project-cover-v1.webp',
    '/images/report-studio/project-cover-v1.webp'
)) {
    if (-not $content.Contains($source)) {
        $failures.Add("Homepage does not reference project cover: $source")
    }
}

foreach ($staleSource in @(
    '/images/callproxy/intro.jpg',
    '/images/report-studio/intro.jpg'
)) {
    if ($content.Contains($staleSource)) {
        $failures.Add("Homepage still references video screenshot: $staleSource")
    }
}

$uniformStyle = 'width: 168px; aspect-ratio: 3 / 2; object-fit: cover;'
if ([regex]::Matches($content, [regex]::Escape($uniformStyle)).Count -ne 2) {
    $failures.Add('Both project covers must use the same 168px-wide 3:2 crop.')
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    exit 1
}

Write-Host 'Homepage project-cover contract passed.'
