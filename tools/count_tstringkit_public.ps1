$ErrorActionPreference = 'Stop'

# Resolve repo directories relative to this script's location so CWD doesn't matter
# Prefer $MyInvocation for widest compatibility; fall back to $PSCommandPath; finally use current directory
if ($MyInvocation -and $MyInvocation.MyCommand -and $MyInvocation.MyCommand.Path) {
  $ScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
}
elseif ($PSCommandPath) {
  $ScriptRoot = Split-Path -Path $PSCommandPath -Parent
}
else {
  $ScriptRoot = (Get-Item -LiteralPath '.').FullName
}
$RepoRoot   = Split-Path -Path $ScriptRoot -Parent
$SrcDir     = Join-Path $RepoRoot 'src'
$IncDir     = Join-Path $SrcDir 'inc'
$SkPath     = Join-Path $SrcDir 'StringKit.pas'

function Get-TStringKitPublicMethods {
  param([string]$Path)

  $lines = Get-Content -LiteralPath $Path

  # Find 'implementation' line index (1-based like LineNumber)
  $implLine = $null
  for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^\s*implementation\b') { $implLine = $i + 1; break }
  }
  if (-not $implLine) { throw 'implementation not found' }

  # Interface section is from 1 to implLine-1 (convert to 0-based index for array slicing)
  $ifaceEnd = $implLine - 2
  if ($ifaceEnd -lt 0) { throw 'invalid interface end index' }
  $iface = $lines[0..$ifaceEnd]

  # Find 'TStringKit = class' start index within interface (0-based)
  $classStartIdx = $null
  for ($i = 0; $i -lt $iface.Count; $i++) {
    if ($iface[$i] -match '^\s*TStringKit\s*=\s*class') { $classStartIdx = $i; break }
  }
  if ($null -eq $classStartIdx) { throw 'TStringKit class not found' }

  $inPublic = $false
  $methods = @()
  for ($i = $classStartIdx; $i -lt $iface.Count; $i++) {
    $l = $iface[$i]
    if ($l -match '^\s*end;') { break }
    if ($l -match '^\s*public\b') { $inPublic = $true; continue }
    if ($l -match '^\s*(published|protected|private|strict\s+private|strict\s+protected)\b') { $inPublic = $false; continue }
    if ($inPublic -and $l -match '^\s*class\s+(function|procedure)\s+(\w+)\b') { $methods += $matches[2] }
  }
  ,$methods
}

try {
  $tkNames = Get-TStringKitPublicMethods -Path $SkPath | Sort-Object -Unique
  $tkCount = $tkNames.Count

  $helperFiles = Get-ChildItem -Path $IncDir -Filter '*.intf.inc' | Sort-Object Name
  # Build a map: Helper function name -> { Name, File, Category }
  $hMap = @{}
  foreach ($hf in $helperFiles) {
    $cat = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileNameWithoutExtension($hf.Name))
    $fileContent = Get-Content -LiteralPath $hf.FullName -Raw
    $matches = [regex]::Matches($fileContent,'(?m)^\s*function\s+(\w+)\b')
    foreach ($m in $matches) {
      $fn = $m.Groups[1].Value
      if (-not $hMap.ContainsKey($fn)) {
        $hMap[$fn] = [PSCustomObject]@{ Name = $fn; File = $hf.Name; Category = $cat }
      }
    }
  }
  $hNames = $hMap.Keys | Sort-Object -Unique
  $hSet   = [System.Collections.Generic.HashSet[string]]::new([string[]]$hNames)

  # Known alias mappings (TStringKitName -> HelperName)
  $aliasMap = [ordered]@{
    ReverseText   = 'Reverse'
    CapitalizeText= 'Capitalize'
    Join          = 'JoinWith'
  }

  $rows = foreach ($n in $tkNames) {
    $helperName = if ($hSet.Contains($n)) {
      $n
    }
    elseif ($aliasMap.Contains($n)) {
      $aliasMap[$n]
    }
    else {
      ''
    }
    $hInfo = if ($helperName) { $hMap[$helperName] } else { $null }
    [PSCustomObject]@{
      Name            = $n
      InHelper        = if ($hInfo) { 'Yes' } else { 'No' }
      HelperName      = if ($hInfo) { $hInfo.Name } else { '' }
      HelperCategory  = if ($hInfo) { $hInfo.Category } else { '' }
      HelperFile      = if ($hInfo) { $hInfo.File } else { '' }
    }
  }

  $covered = ($rows | Where-Object InHelper -eq 'Yes').Count
  $missing = ($rows | Where-Object InHelper -eq 'No').Count

  # Ensure tools directory exists
  $outDir = $ScriptRoot
  if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }

  # Write summary
  $summaryPath = Join-Path $outDir 'summary.txt'
  $aliasSummary = if ($aliasMap.Count -gt 0) {
    'Known different names: ' + (
      ($aliasMap.GetEnumerator() | ForEach-Object { "{0}->{1}" -f $_.Key, $_.Value }) -join ', '
    )
  } else { '' }
  @(
    'Summary:'
    "TStringKit public count: $tkCount"
    "Helper method count: $($hNames.Count)"
    "Covered: $covered"
    "Missing: $missing"
    $aliasSummary
  ) | Set-Content -Path $summaryPath -Encoding UTF8

  # Write coverage markdown
  $coveragePath = Join-Path $outDir 'coverage.md'
  $md = @()
  $md += '| Method | In Helper | Helper Name | Helper Category | Helper File |'
  $md += '|---|---|---|---|---|'
  foreach ($r in $rows) { $md += "| $($r.Name) | $($r.InHelper) | $($r.HelperName) | $($r.HelperCategory) | $($r.HelperFile) |" }
  $md | Set-Content -Path $coveragePath -Encoding UTF8

  # Also write a machine-readable JSON if needed
  $jsonPath = Join-Path $outDir 'coverage.json'
  $obj = [PSCustomObject]@{
    TStringKitPublicCount = $tkCount
    HelperMethodCount     = $hNames.Count
    Covered               = $covered
    Missing               = $missing
    Methods               = $rows
  }
  $obj | ConvertTo-Json -Depth 4 | Set-Content -Path $jsonPath -Encoding UTF8

  Write-Output "Wrote: $summaryPath"
  Write-Output "Wrote: $coveragePath"
  Write-Output "Wrote: $jsonPath"
}
catch {
  $outDir = 'tools'
  if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
  $summaryPath = Join-Path $outDir 'summary.txt'
  "Error: $($_.Exception.Message)" | Set-Content -Path $summaryPath -Encoding UTF8
  throw
}
