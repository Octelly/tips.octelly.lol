# Installing Arch Linux

!!! abstract "Read this first"

    The [ArchWiki][archwiki] should always be regarded as the most up to date source of information. This guide serves as nothing but a simplified and hopefully easier to follow guide of the [official installation guide][archwiki-installation_guide]. I or any other contributors to this guide are responsible for what you do with your system. This simplified guide is primarily recommended to be either used as a basic skeleton (I'll try to link to official sources wherever possible) or if you're already familiar with installing Arch Linux yourself and just need a quick refresher.

!!! warning

    This guide only goes over what I see as the most common parts of a regular installation. If you have any specialised or irregular hardware (or are simply unsure), please see the official [wiki][archwiki] and [guide][archwiki-installation_guide]. This guide is also not suitable for absolute beginners for the same reasons. If you're new to this, try installing Arch Linux for the first time in a virtual machine.

!!! note

    This guide does not make use of [Arch Installer][github-archinstall].

!!! info

    I recommend you read through the guide at least once before doing anything else.


## Obtaining an installation medium

I highly recommend that you use [SystemRescue][systemrescue-download] over the official [ArchISO][archlinux-download] as it provides a basic desktop environment which signifficantly simplifies the installation process. This guide will assume that you're using SystemRescue, however you're free to follow along with either.

After downloading either of the two you need to flash them on a storage device, preferably a flash drive. You can use [dd](/software/image-flashing/#dd), but if you're not comfortable with tools where a simple mistake can wipe your data, I'd recommend something like [Balena Etcher](/software/image-flashing/#balena-etcher)

## Booting into the installation medium

??? warning "Installing on the same device?"

    If you're not familiar with the installation process, please make sure you can follow the guide even while often if your device isn't hardwired to the internet. You can open the guide on your phone. Also consider reading this chapter before continuing.

Once you have your flash drive ready, plug it into the target system and power it on. You'll need to get to the boot or firmware menu. What follows are some tips on how to get there.

=== "Generic / without an operating system"

    On most systems (laptop / desktop motherboard brands) you need to press (ideally mash to be extra sure) a specific key on your keyboard. The most common ones are ++f2++ and ++del++.

    ??? example "List of keys for common manufacturers"

        | Manufacturer       | Key                                                      |
        |--------------------|----------------------------------------------------------|
        | ASRock             | ++f2++ or ++del++                                        |
        | ASUS               | ++f2++ or ++del++                                        |
        | Acer               | ++f2++ or ++del++                                        |
        | Dell               | ++f2++ or ++f12++                                        |
        | Gigabyte           | ++f2++ or ++del++                                        |
        | HP                 | ++f10++                                                  |
        | Lenovo & Thinkpads | ++f2++, ++fn+f2++, ++f1++, ++enter++ or **ThinkVantage** |
        | MSI                | ++del++                                                  |
        | MS Surface tablets | hold ++volume-up++                                       |
        | Toshiba            | ++f2++                                                   |

        Source: [Tom's Hardware](https://www.tomshardware.com/reviews/bios-keys-to-access-your-firmware,5732.html). May not be 100% accurate.

=== ":fontawesome-brands-linux: Linux"

    You might be able to use the `systemctl reboot --firmware` command. Running as root (via sudo usually) may be necessary.

=== ":fontawesome-brands-windows: Windows 10/11"

    !!! note "Note: The first 2 steps may differ slightly for some."

    1. Search for "advanced startup" in the start menu
    2. Select "Restart now"
        - Let the computer restart (make sure it restarts into the same Windows installation on multi-booted systems)
    3. Select "Troubleshoot"
    4. Select "Advanced options"
    5. Select "UEFI Firmware Settings"
        - Might be named something else or be entirely missing for some
    6. Select "Restart"

??? info "Connecting to wifi"

    If your device isn't hardwired to the internet, you will need to connect to a wifi network. Use the icon in the bottom right.

## Partitioning

Assuming a dedicated drive, create a new partition table. In GParted, select the correct drive in the top right and then go to `Device`&nbsp;>&nbsp;`Create Partition Table`. Most devices should nowadays support EFI, but if you're installing on an older device, it might only support legacy BIOS booting.

=== "EFI"

    Choose GPT for the partition table.

=== "BIOS"

    Choose MBR for the partition table[^1].

### Adding partitions

#### Root

This will be the `/` path on your system. The most popular partition format for storage partitions on Linux is ext4, however you may want to consider other option as well, such as `btrfs`. This guide will assume you're using ext4.

#### Home (optional)

Home is the `/home` path on your system. It might be desirable to make this a separate partition, since this is where all your documents and user settings go. If you make this into a separate partition, you could safely reinstall the rest of your system in the future without having to touch this partition (aka your data) at all. I recommend going with the same partition format as you did with for the [root partition](#root).

#### Swap

Swap is an important part that you should ideally not skip over, albeit technically possible. In simple terms, it is used as an extension for your RAM, meaning if you run out of it, the kernel (in this case Linux itself) can move a background application to the swap, which in my opinion is a solid alternative to your system freezing.

=== "With hybrid-sleep/hibernation support"

    I recommend making the size of the swap partition about 2x your RAM size if you can afford it. The minimum should be at least around 1.2x, since the entire RAM gets saved to the swap when you system is put into hibernation and there might already be something in there.

=== "Without"

    A decent sized swap should be the same size as your RAM or at least half. If you're feeling risky you can also just not create a swap partition at all, however I seriously recommend against doing that.

Swap has its own partition format.

#### Boot

Unless you have another system on your computer that can handle the boot process instead, you'll definitely need a boot partition[^2]. This is where your boot loader will go, which handles the loading of your system's kernel. This guide assumes you're installing GRUB as the boot loader.

=== "EFI"

    Create a FAT32 partition. This shouldn't have to be larger than about 100 MiB.

=== "BIOS"

    If you've gone with MBR for the partition table, then there shouldn't be anything you need to do. In case you're interested in other options, see the [BIOS systems part of the GRUB ArchWiki page][archwiki-grub-bios].


### Mounting partitions

!!! warning "Make sure you've applied all the operations in GRUB first, they do not get applied as you make changes in the GUI automatically."

The mount command you'll use is `mount /path/to/partition /mount/point`. It is convention to make the root of the system you're working on in `/mnt`. This folder might not exist, use `mkdir -p /mnt` to create it.

```sh title="Example"
# root partition
mkdir -p /mnt
mount /dev/sda2 /mnt

# boot partition
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

# home partition
mkdir -p /mnt/home
mount /dev/sda3 /mnt/home

# swap
swapon /dev/sda3
```

1. Mount all the storage partitions to the mount points described in [Adding partitions](#adding-partitions)
2. Mount the boot partition you've made (if you've made one) to `/boot`
3. Activate the swap partition you've made with `swapon /path/to/partition`

??? question "`fuse: failed to access mountpoint /some/path: No such file or directory`"

    Before you can mount a partition, you always need to create the directory you want to mount it at. If the directory doesn't exist (aka you get this error) simply create it with `mkdir -p /some/path`.

??? question "How do I get the `/path/to/partition`?"

    In GParted you can see the path in the `Partition` column.
    
    For sata drives it usually looks like `/dev/sdXY`, for NvME ones it's usually `/dev/nvmeXnYpZ`.

    You may also try to consult `lsblk`.

## A new Arch Linux installation

In this section we will run `pacstrap` thus setting up the Arch Linux package manager, pacman.

### Choosing the right base packages

The following sections will help you compile a list of packages you'll want to include in your install.

!!! note "Note: You can install these packages later on, but doing it all in one command means, that you can let it install in the background and get a cup of coffee or something in the meantime"

#### Stuff that you'll always want (all)

- `base` - a package group containing all the packages you will always want on an Arch Linux system
- `man-db` and `man-pages` - a manual for all[^3] your installed packages you can always access with `man`
- `networkmanager` - handles wired and wireless internet for you, including VPNs and other extra stuff

#### A text editor (at least one)

It is essential that you pick at least one editor that you can use in the terminal. Here are my recommendations:

- `vim` -  if you know Vim, you'll want to use it
- `neovim` - Vim, but supercharged
- `nano` - I personally hate Nano, but it is probably the most user friendly terminal text editor out there

#### Kernel flavours (choose one)

You need to install a kernel as it is the heart of any operating system. Linux itself is a kernel and everything around it are applications that make it into a proper operating system. Here are some kernel recommendations (I always go with `linux-zen`):

- `linux` - a regular Linux kernel, I generally avoid this one, but it is the most neutral choice
- `linux-lts` - a long-term support release of the kernel, meaning you can stay on the same version for a while with only smaller bugfixes being applied
- `linux-zen` - the best kernel flavour for an everyday system, provides great performance for desktops and laptops
- `linux-hardened` - Linux kernel with extra security patches applied


[^1]: It is possible to use GPT with BIOS as well. If you're interested, you can check out the [different ways of setting up GRUB on BIOS systems here][archwiki-grub-bios].
[^2]: Not sure if you can actually omit the boot partition at all, I recommend making one either way.
[^3]: Packages can technically leave the manual out, but most do ship with one and it is only the most reliable source of information (albeit without any pictures or other things to keep the reader engaged).


[archwiki]: https://wiki.archlinux.org "ArchWiki"
[archwiki-installation_guide]: https://wiki.archlinux.org/title/Installation_guide "ArchWiki - Installaion Guide"
[archwiki-grub-bios]: https://wiki.archlinux.org/title/GRUB#BIOS_systems "ArchWiki - GRUB - BIOS systems"

[archlinux-download]: https://archlinux.org/download/ "Arch Linux Downloads"

[systemrescue-download]: https://www.system-rescue.org/Download/ "SystemRescue - Download"

[github-archinstall]: https://github.com/archlinux/archinstall "archlinux/archinstall on GitHub"