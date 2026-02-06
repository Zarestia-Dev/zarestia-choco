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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.1/RClone.Manager_0.2.1_x64_en-US.msi'
  $packageArgs.checksum64 = 'f3d5b0599debcc3fb1abd2943f3261335a717f79516a31d50eeb489c6ef61b9a'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.1/RClone.Manager_0.2.1_arm64_en-US.msi'
  $packageArgs.checksum64 = 'da80e7576504588b8860d730422c4f531a99770ef74095d3dad81bff96a6ebb0'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs