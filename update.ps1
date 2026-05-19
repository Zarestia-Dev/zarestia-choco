$ErrorActionPreference = 'Stop'

$owner = "Zarestia-Dev"
$repo = "rclone-manager"

Write-Host "Fetching latest release from GitHub API for $owner/$repo..." -ForegroundColor Green
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/releases/latest"
$version = $release.tag_name.TrimStart('v')
Write-Host "Latest version found: $version" -ForegroundColor Yellow

$x64Url = "https://github.com/Zarestia-Dev/rclone-manager/releases/download/v$version/RClone.Manager_$($version)_x64_en-US.msi"
$arm64Url = "https://github.com/Zarestia-Dev/rclone-manager/releases/download/v$version/RClone.Manager_$($version)_arm64_en-US.msi"

$tempDir = Join-Path $env:TEMP "choco_tmp_$version"
if (!(Test-Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir | Out-Null }

$x64Path = Join-Path $tempDir "x64.msi"
$arm64Path = Join-Path $tempDir "arm64.msi"

Write-Host "Downloading x64 MSI..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $x64Url -OutFile $x64Path
Write-Host "Downloading arm64 MSI..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $arm64Url -OutFile $arm64Path

Write-Host "Calculating SHA256 checksums..." -ForegroundColor Green
$x64Hash = (Get-FileHash -Path $x64Path -Algorithm SHA256).Hash.ToLower()
$arm64Hash = (Get-FileHash -Path $arm64Path -Algorithm SHA256).Hash.ToLower()

Write-Host "x64 SHA256: $x64Hash" -ForegroundColor Yellow
Write-Host "arm64 SHA256: $arm64Hash" -ForegroundColor Yellow

$installScriptPath = Join-Path $PSScriptRoot "rclone-manager\tools\chocolateyInstall.ps1"
$nuspecPath = Join-Path $PSScriptRoot "rclone-manager\rclone-manager.nuspec"
$readmePath = Join-Path $PSScriptRoot "README.md"

if (Test-Path $installScriptPath) {
    Write-Host "Updating chocolateyInstall.ps1..." -ForegroundColor Green
    $lines = Get-Content $installScriptPath
    for ($i=0; $i -lt $lines.Length; $i++) {
        if ($lines[$i] -match "url64bit\s*=\s*'.*_x64_.*\.msi'") {
            $lines[$i] = "  `$packageArgs.url64bit = '$x64Url'"
            $lines[$i+1] = "  `$packageArgs.checksum64 = '$x64Hash'"
        }
        elseif ($lines[$i] -match "url64bit\s*=\s*'.*_arm64_.*\.msi'") {
            $lines[$i] = "  `$packageArgs.url64bit = '$arm64Url'"
            $lines[$i+1] = "  `$packageArgs.checksum64 = '$arm64Hash'"
        }
    }
    $lines | Set-Content $installScriptPath
    Write-Host "  Success" -ForegroundColor Green
}

if (Test-Path $nuspecPath) {
    Write-Host "Updating rclone-manager.nuspec..." -ForegroundColor Green
    $nuspecContent = Get-Content $nuspecPath -Raw
    $nuspecContent = $nuspecContent -replace "<version>[\d\.]+</version>", "<version>$version</version>"
    Set-Content -Path $nuspecPath -Value $nuspecContent -NoNewline
    Write-Host "  Success" -ForegroundColor Green
}

if (Test-Path $readmePath) {
    Write-Host "Updating README.md with the new version as example..." -ForegroundColor Green
    $readmeContent = Get-Content $readmePath -Raw
    $readmeContent = $readmeContent -replace "rclone-manager\.[\d\.]+\.nupkg", "rclone-manager.$version.nupkg"
    Set-Content -Path $readmePath -Value $readmeContent -NoNewline
    Write-Host "  Success" -ForegroundColor Green
}

Write-Host "Cleaning up temp files..." -ForegroundColor Green
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Update Complete!" -ForegroundColor Green
