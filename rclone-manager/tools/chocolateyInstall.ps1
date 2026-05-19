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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.6/RClone.Manager_0.2.6_x64_en-US.msi'
  $packageArgs.checksum64 = '94f1cba063a42184a4c36dfc8e685f530b279d089b9c2dedb41fdee60de91bf8'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.6/RClone.Manager_0.2.6_arm64_en-US.msi'
  $packageArgs.checksum64 = '7f29a3f3d682eec71e12c68432986b743b2329fabfb6d0aa82407d260b4eaa24'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs
