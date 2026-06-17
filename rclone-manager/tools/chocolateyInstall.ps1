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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.8/RClone.Manager_0.2.8_x64_en-US.msi'
  $packageArgs.checksum64 = 'c8ab4f003e26d49b328dcf20efea4c9b51a4e3761893e79dacce3772457354c6'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.8/RClone.Manager_0.2.8_arm64_en-US.msi'
  $packageArgs.checksum64 = '22003d6f5b5f97d11202ab8c720bd231f49415534262117b6f981b7ae517053e'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs
