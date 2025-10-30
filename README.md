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

