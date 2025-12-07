# <h1 align="center">zarestia-choco</h1>

<p align="center">
    <img src="assets/zarestia-choco.png" alt="zarestia-choco logo" width="320" />
</p>

A collection of Chocolatey packages maintained by Zarestia-Dev. This repository hosts Chocolatey packaging for one or more applications (for example, the `rclone-manager` package). It is no longer limited to a single package for RClone Manager.

## Description

This repository contains Chocolatey packaging and helper scripts for distributing Windows packages via Chocolatey. Packages here wrap graphical and command-line applications so they can be installed and managed using Chocolatey.

> Note: The repository was previously focused on RClone Manager; it has been renamed to `zarestia-choco` to reflect a broader scope.

## Installation

Install a package published from this repository using Chocolatey. Example (RClone Manager package):

```powershell
choco install rclone-manager
```

Replace `rclone-manager` with the package name you want to install.

## Requirements

- Windows 7 or later (64-bit or ARM64)
- Chocolatey package manager (https://chocolatey.org/)

## What you'll find here

- `.nuspec` files and packaging metadata for Chocolatey
- `tools/` with installation scripts such as `chocolateyInstall.ps1`
- Release notes and package-specific helpers

## Usage

After installing a package (for example, `rclone-manager`), launch the installed application from the Start menu or desktop shortcut created by the package. For package-specific usage and documentation, follow links in the package repository or upstream project documentation.

## Building and Publishing

### Building a Chocolatey Package

To build a `.nupkg` file from a package (for example, `rclone-manager`):

1. Navigate to the package directory:
   ```powershell
   cd rclone-manager
   ```

2. Pack the package using the Chocolatey CLI:
   ```powershell
   choco pack
   ```

   This will generate a `.nupkg` file (for example, `rclone-manager.0.1.8.nupkg`) in the current directory.

3. **Test locally** before publishing:
   ```powershell
   choco install rclone-manager -source . -y
   ```

   This installs the package from the local `.nupkg` file to verify it works correctly.

### Publishing to Chocolatey Community Repository

To publish your package to the [Chocolatey Community Repository](https://community.chocolatey.org/):

1. **Create a Chocolatey account** at https://community.chocolatey.org/account/Register if you don't have one.

2. **Get your API key** from your account page at https://community.chocolatey.org/account.

3. **Set your API key** (one-time setup):
   ```powershell
   choco apikey --key YOUR_API_KEY_HERE --source https://push.chocolatey.org/
   ```

4. **Push the package**:
   ```powershell
   choco push rclone-manager.0.1.8.nupkg --source https://push.chocolatey.org/
   ```

   Replace `rclone-manager.0.1.8.nupkg` with your actual package filename.

5. **Wait for moderation**: Your package will be reviewed by the Chocolatey moderators. You'll receive notifications about the status via email.

### Updating a Package

When releasing a new version:

1. Update the `<version>` in the `.nuspec` file.
2. Update download URLs and checksums in `tools/chocolateyInstall.ps1`:
   - Get SHA256 checksums using:
     ```powershell
     Get-FileHash -Path "path\to\installer.msi" -Algorithm SHA256
     ```
3. Update release notes and any other metadata in the `.nuspec`.
4. Build and test locally (see steps above).
5. Push the new version to Chocolatey.

### Tips

- Use `choco pack --version X.Y.Z` to override the version in the `.nuspec` if needed.
- Always test installation, upgrade, and uninstallation locally before pushing.
- Keep your API key secure and never commit it to the repository.
- Follow [Chocolatey packaging guidelines](https://docs.chocolatey.org/en-us/create/create-packages) for best practices.

## Contributing

Contributions are welcome. To contribute packaging or updates:

1. Fork this repository
2. Create a feature branch
3. Update the `.nuspec` and files under `tools/` as needed
4. Test packaging locally using `choco pack` and local install testing
5. Open a pull request with a clear description of the change

When updating a package, ensure you bump the version in the `.nuspec` and update checksums or download URLs if applicable.

## Issues

Report issues related to these Chocolatey packages on this repository's GitHub Issues page. For issues with upstream applications (for example, RClone Manager), open issues on the upstream project's issue tracker.

## License

This Chocolatey package is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

