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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.8/RClone.Manager_0.1.8_x64_en-US.msi'
  $packageArgs.checksum64 = 'c74aad7f6031ebb5b74ab4b9fa0e7ea3836f75fe656363097dbdf50c4543da1b'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.8/RClone.Manager_0.1.8_arm64_en-US.msi'
  $packageArgs.checksum64 = 'a5ec3a704dc3fb6f2469112be5a0c2e953e70df800b36b11ae74f8328e45d513'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs