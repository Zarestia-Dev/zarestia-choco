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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.3/RClone.Manager_0.2.3_x64_en-US.msi'
  $packageArgs.checksum64 = '9130C2628DE666267D16FEFE373F3053C73DFDF579FE355F9149949EA541D0AB'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.3/RClone.Manager_0.2.3_arm64_en-US.msi'
  $packageArgs.checksum64 = '2ED17B96CEBA1DF9958FBEB727D761A0ED9148BB7ACC7D5E77CA617E5E697316'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs