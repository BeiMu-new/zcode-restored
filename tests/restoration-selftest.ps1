# tests/restoration-selftest.ps1
# Integrity self-test for the restored layer.
#
# Simulates a "stripped" target, runs apply-restoration.ps1, then verifies every
# file in restored/MANIFEST.sha256 is present and byte-identical (sha256).
#
# Usage:  powershell -ExecutionPolicy Bypass -File .\tests\restoration-selftest.ps1
$ErrorActionPreference = "Stop"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
$restored = Join-Path $root "restored"
$manifest = Join-Path $restored "MANIFEST.sha256"
$apply = Join-Path $root "apply-restoration.ps1"

if (-not (Test-Path $manifest)) { Write-Error "MANIFEST.sha256 not found: $manifest"; exit 1 }

$tmp = Join-Path $env:TEMP ("zcode-restore-selftest-" + [Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

Write-Host "== Restoration self-test =="
Write-Host "temp target : $tmp"

# 1) Simulate the open-source "stripped" state: a stub where the plugin should be.
$stubDir = Join-Path $tmp "glm\packages\zcode-cua-plugin"
New-Item -ItemType Directory -Force -Path $stubDir | Out-Null
Set-Content -Path (Join-Path $stubDir "index.js") -Value "// Computer Use is not available in this build." -Encoding ASCII
Write-Host "[stub] wrote stripped placeholder: glm/packages/zcode-cua-plugin/index.js"

# 2) Apply the restoration.
Write-Host "[run ] apply-restoration.ps1 -Target <temp>"
& powershell -ExecutionPolicy Bypass -File $apply -Target $tmp | Out-Host

# 3) Verify every manifest entry.
function Get-Sha256([string]$p) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $fs = [System.IO.File]::OpenRead($p)
    try { return ([BitConverter]::ToString($sha.ComputeHash($fs)) -replace "-", "").ToLower() } finally { $fs.Close() }
}

$lines = Get-Content $manifest
$total = 0; $ok = 0; $missing = 0; $mismatch = 0
$bad = @()
foreach ($ln in $lines) {
    if (-not $ln.Trim()) { continue }
    $total++
    $parts = $ln -split "  ", 2
    $want = $parts[0].Trim()
    $rel = $parts[1].Trim()
    $f = Join-Path $tmp ($rel -replace "/", "\")
    if (-not (Test-Path $f)) { $missing++; $bad += ("MISSING  " + $rel); continue }
    $got = Get-Sha256 $f
    if ($got -eq $want) { $ok++ } else { $mismatch++; $bad += ("MISMATCH " + $rel) }
}

Write-Host ""
Write-Host "== Result =="
Write-Host ("total   : " + $total)
Write-Host ("ok      : " + $ok)
Write-Host ("missing : " + $missing)
Write-Host ("mismatch: " + $mismatch)
if ($bad.Count -gt 0) { Write-Host "first problems:"; $bad | Select-Object -First 10 | ForEach-Object { Write-Host ("  " + $_) } }

# cleanup
Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue

if ($missing -eq 0 -and $mismatch -eq 0) {
    Write-Host "SELFTEST: PASS"
    exit 0
} else {
    Write-Host "SELFTEST: FAIL"
    exit 1
}