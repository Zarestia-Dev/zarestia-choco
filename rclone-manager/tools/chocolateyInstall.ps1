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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.9/RClone.Manager_0.1.9_x64_en-US.msi'
  $packageArgs.checksum64 = 'deb52412fc717098b7d3dede211fa281847087bce2980374fb4b0bf13c3af466'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.1.9/RClone.Manager_0.1.9_arm64_en-US.msi'
  $packageArgs.checksum64 = '61cd3d13b1996393de234cd9583da0115bef52f5f8e4ffae11ebd6745a079831'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs