param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $FlutterArguments = @("run")
)

$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$junctionPath = "C:\rgprs_jk_run"

if (-not (Test-Path $junctionPath)) {
    New-Item -ItemType Junction -Path $junctionPath -Target $projectRoot | Out-Null
}

$junction = Get-Item $junctionPath
if ($junction.LinkType -ne "Junction" -or $junction.Target -notcontains $projectRoot) {
    throw "$junctionPath must be a junction targeting $projectRoot."
}

$localProperties = Join-Path $projectRoot "android\local.properties"
$flutterSdk = (
    Get-Content $localProperties |
    Where-Object { $_ -match "^flutter\.sdk=" } |
    Select-Object -First 1
) -replace "^flutter\.sdk=", ""

if ([string]::IsNullOrWhiteSpace($flutterSdk)) {
    throw "flutter.sdk is missing from android\local.properties."
}

$flutterCommand = Join-Path $flutterSdk "bin\flutter.bat"
if (-not (Test-Path $flutterCommand)) {
    throw "Flutter SDK was not found at $flutterSdk."
}

Push-Location $junctionPath
try {
    & $flutterCommand @FlutterArguments
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
