# Storage space

## Automatic cleaners

### BleachBit :fontawesome-brands-linux: :fontawesome-brands-windows:

![](https://images.weserv.nl/?url=www.bleachbit.org/images/bleachbit320_windows10_preview.png){ align=right width=350 }

An open-source, cross-platform program available on Linux and Windows. Can clean system and application files. To keep it simple, here's a short list of some of the stuff it can clean: Discord, Google Chrome, Firefox, Thunderbird, VLC, trash, cache, custom directories and more.

- [:material-arch: Arch Linux repositories][bleachbit-arch]
- [:material-nix: Nixpkgs][bleachbit-nixpkgs]
- [:fontawesome-brands-windows: Winget][bleachbit-winget]
- [:material-earth: Other][bleachbit-all]

## Tree visualisers

See how many % each folder takes up.

### Treesize :fontawesome-brands-windows:

![](https://images-eds-ssl.xboxlive.com/image?url=4rt9.lXDC4H_93laV1_eHM0OYfiFeMI2p9MWie0CvL99U4GA1gf6_kayTt_kBblFwHwo8BW8JXlqfnYxKPmmBdztSSR_EBHLTm_Rgd1sgTmf3mm8X6SLqOGCVWc.yFB.nT_Vw1flOVoQY7njT.2uK87C9Nj5qTgY_BCh1PHceR4-){ align=right width=350 }

Treesize is a freemium, Windows-only, program. It features a decent-looking GUI and is [available on the MS Store][treesize-ms] for automatic updates.

- [:fontawesome-brands-windows: Winget][treesize-winget]
- [:fontawesome-brands-microsoft: MS Store][treesize-ms]

### gdu :fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

![](/assets/gdu-screenshot.png){ align=right width=350 }

GDU is an open-source and cross-platform TUI program. It is fast and quite intuitive, if you're not afraid of the terminal. Find a package for your system (including Windows) [here][gdu-all].

- [:material-arch: Arch Linux repositories][gdu-arch]
- [:material-nix: Nixpkgs][gdu-nixpkgs]
- [:simple-homebrew: Homebrew formula][gdu-brew]
- [:fontawesome-brands-windows: Winget][gdu-winget]
- [:material-earth: Other][gdu-all]

??? question "Alternatives to gdu"

    You might already know alternative such as ncdu and these are very similar tools. I decided to put priorities gdu here, as it is signifficantly faster than the alternative I've tried, especially on an SSD. See some (possibly biased) comparisons [here](https://github.com/dundee/gdu#profiling).

[bleachbit-arch]: https://archlinux.org/packages/extra/any/bleachbit/ "BleachBit on Arch Linux repositories"
[bleachbit-nixpkgs]: https://search.nixos.org/packages?channel=unstable&show=bleachbit&query=bleachbit "BleachBit on Nixpkgs"
[bleachbit-winget]: https://winstall.app/apps/BleachBit.BleachBit "BleachBit via Winget"
[bleachbit-all]: https://repology.org/project/bleachbit/versions "BleachBit on Repology"

[treesize-ms]: https://apps.microsoft.com/store/detail/treesize-free/XP9M26RSCLNT8 "Treesize on Microsoft Store"
[treesize-winget]: https://winstall.app/apps/JAMSoftware.TreeSize.Free "Treesize via Winget"

[gdu-arch]: https://archlinux.org/packages/extra/x86_64/gdu/ "gdu on Arch Linux repositories"
[gdu-nixpkgs]: https://search.nixos.org/packages?channel=unstable&show=gdu&query=gdu "gdu on Nixpkgs"
[gdu-brew]: https://formulae.brew.sh/formula/gdu "gdu Homebrew formula"
[gdu-winget]: https://winstall.app/apps/dundee.gdu "gdu via Winget"
[gdu-all]: https://repology.org/project/gdu/versions "gdu on Repology"