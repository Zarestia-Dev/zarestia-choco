$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  silentArgs     = "/quiet /norestart"
  validExitCodes = @(0, 3010, 1641)
}

# Check system architecture and set the correct URL and checksum
$procArch = Get-ProcessorBits

if ($procArch -eq 64) {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.5/RClone.Manager_0.1.5_x64_en-US_windows.msi'
  $packageArgs.checksum64 = '172243b97063bc705cf92eedf046ec35c9f195d6f90115d15612b500e5e8a4d1'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.5/RClone.Manager_0.1.5_arm64_en-US_windows.msi'
  $packageArgs.checksum64 = 'f632fdd219d2d40f7dd1e0f5fe308b29ccc901cd240b8b981c7aebc393dcd0e9'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs