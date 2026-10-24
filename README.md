# Homebrew Tap (tkjaer)

This repository contains Homebrew formulae maintained by **@tkjaer**.

## Usage

Add the tap:

```sh
brew tap tkjaer/tap
```

Install a formula:

```sh
brew install etr
```

Upgrade installed formulae:

```sh
brew upgrade
```

## Formulae

- **etr** — ECMP traceroute tool with path detection and visualization support  
  Project: https://github.com/tkjaer/etr

## Troubleshooting

- If you run into build issues, ensure Homebrew is up to date:

```sh
brew update
```

- For issues with **etr** specifically, please report them on the main project repo:  
  https://github.com/tkjaer/etr/issues

## Maintaining the tap

Changes to `main` must go through a pull request, including administrator changes.
Force pushes and branch deletion are blocked. Reviewer approval is not required,
so the maintainer can merge their own pull requests.

When bumping a formula's version, remove its `bottle do … end` block in the same
pull request. The old block points at the previous release's bottles, which
would make installs fail until new bottles exist. Without it, installs build
from source in the meantime.

Bottles are only built on `macos-latest` (Apple Silicon), because Homebrew no
longer provides Intel bottles for build dependencies such as `go`. Intel Macs
can use the prebuilt `etr-darwin-amd64` binary from the etr releases instead.

After a formula update is merged, the Bottles workflow builds and uploads bottles,
then opens a separate pull request with the updated bottle metadata. Review and
merge that pull request, keeping `[bottles]` in the merge commit message to avoid
triggering another bottle build. Manual bottle runs must target `main`.

The repository Actions setting **Allow GitHub Actions to create and approve pull
requests** must be enabled for the workflow to open these pull requests. The
workflow does not approve or merge them and has no bypass of branch protection.
