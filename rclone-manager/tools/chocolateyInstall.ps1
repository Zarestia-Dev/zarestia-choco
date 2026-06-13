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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.7/RClone.Manager_0.2.7_x64_en-US.msi'
  $packageArgs.checksum64 = '0751a902c95e2cfb1c1244fd35b1546b2646e68e7a76e08ca1c0834b79cb2749'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.7/RClone.Manager_0.2.7_arm64_en-US.msi'
  $packageArgs.checksum64 = '43a5dd8ebf3cc471580f639d75cba3a971c87df69113d877b8ce8e2fc4cd46a8'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs
