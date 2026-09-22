# apply-restoration.ps1
# Copy the restored official plugin layer into a ZCode resources directory.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File .\apply-restoration.ps1 -Target "C:\path\to\ZCode\resources"
#
param(
    [Parameter(Mandatory = $true)]
    [string]$Target
)

$ErrorActionPreference = "Stop"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$src  = Join-Path $here "restored"

if (-not (Test-Path $src))  { Write-Error "restored/ not found next to this script."; exit 1 }
if (-not (Test-Path $Target)) { Write-Error "Target resources dir not found: $Target"; exit 1 }

Write-Host "[1/3] Copying plugins -> $Target\glm\packages\"
$dstPkgs = Join-Path $Target "glm\packages"
New-Item -ItemType Directory -Force -Path $dstPkgs | Out-Null
Copy-Item -Path (Join-Path $src "glm\packages\*") -Destination $dstPkgs -Recurse -Force

Write-Host "[2/3] Copying cua-helper -> $Target\tools\cua-helper\"
$dstTools = Join-Path $Target "tools"
New-Item -ItemType Directory -Force -Path $dstTools | Out-Null
Copy-Item -Path (Join-Path $src "tools\cua-helper") -Destination $dstTools -Recurse -Force

Write-Host "[3/3] Done."
Get-ChildItem (Join-Path $dstPkgs "*") -Directory | ForEach-Object { Write-Host ("  - " + $_.Name) }