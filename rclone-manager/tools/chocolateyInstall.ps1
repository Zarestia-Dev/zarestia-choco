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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.2/RClone.Manager_0.2.2_x64_en-US.msi'
  $packageArgs.checksum64 = 'D16D726C3C992ED3AD61E89D0C9FEA36D2A7822A4B55CF402E798E02D032DB9C'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.2/RClone.Manager_0.2.2_arm64_en-US.msi'
  $packageArgs.checksum64 = '120E165413AAA9E134250E0F69001DD5783A39A9965BF1EECD4080276811577F'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs