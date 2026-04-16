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
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.4/RClone.Manager_0.2.4_x64_en-US.msi'
  $packageArgs.checksum64 = 'FFE2101E9A2873F13DE761054572C5DF90FC223A06037343FCD85425E9495333'
} elseif ($procArch -eq 'arm64') {
  $packageArgs.url64bit = 'https://github.com/Zarestia-Dev/rclone-manager/releases/download/v0.2.4/RClone.Manager_0.2.4_arm64_en-US.msi'
  $packageArgs.checksum64 = '9342EB0A89FDB2DC21B9D89F5F7ED7062DD1F78B0998DEDCA480F224C0019962'
} else {
  throw "This package does not support the $($procArch) architecture."
}

$packageArgs.checksumType64 = 'sha256'

Install-ChocolateyPackage @packageArgs