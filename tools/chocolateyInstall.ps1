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
  $packageArgs.url64bit = 'https://github.com/RClone-Manager/rclone-manager/releases/download/v0.1.4/RClone.Manager_0.1.4_x64_en-US.msi'
  $packageArgs.checksum64 = '0010fd92b99c31d37634e592fbe728bbddf2b20bd9b8cae32490b43e1d75bc32'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/RClone-Manager/rclone-manager/releases/download/v0.1.4/RClone.Manager_0.1.4_arm64_en-US.msi'
  $packageArgs.checksum64 = '9c4feff47d7c813f481b64d007973ec425872b908fefd24d907b76a83ecd55d0'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs