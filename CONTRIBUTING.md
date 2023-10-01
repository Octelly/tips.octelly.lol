# How to contribute

## Preparing a work environment

The project's dependencies are managed via a Nix flake. If you do not have Nix available on your system, I highly recommend you use [Determinate Systems' Nix installer](https://zero-to-nix.com/start/install) as it is easy to uninstall later on if you need to and seems to generally be better put together than the alternatives. Short tangent: I've recently had to clean up after a Nix installation from the official Arch Linux repositories.

> [!NOTE]
> You will probably want to make a fork if you actually want to contribute and git clone that instead.

1. Clone the repo: `git clone git@github.com:Octelly/tips.octelly.lol.git`
2. Enter the development environment: `nix develop .`
3. Open your favourite editor (in the environment), I recommend VSCode as this repo includes some workspace-specific settings for that.
