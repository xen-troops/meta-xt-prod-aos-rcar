# meta-xt-prod-aos-rcar #

This repository contains Renesas RCAR Gen3-specific Yocto layers for
Aos distro and `moulin` project file to build it. Layers in this
repository provide final recipes to build meta-xt-prod-aos-rcar
distro. This distro is the Aos product for Renesas boards.

Those layers *may* be added and used manually, but they were written
with [Moulin](https://moulin.readthedocs.io/en/latest/) build system,
as Moulin-based project files provide correct entries in local.conf

# Moulin project file

Work is still in progress, but right now the following features are tested and working:

* AosBox with Starter Kit Premiere 8GB board
* 3 domains are being built: Linux based Dom0, DomD and DomF where DomF is main Aos domain
* Networking in DomD and DomF
* OP-TEE client in DomF
* Virtualized OP-TEE build
* ARM-TF that boots into EL2
* SD or eMMC boot

Features that are present but not tested:

* Renesas Salvator-XS M3 with 8GB memory is supported
* Renesas Salvator-X H3 with 8GB memory is supported
* Renesas Starter Kit Premiere 8GB (H3ULCB)
* Kingfisher with Starter Kit Premiere 8GB board
* Renesas Salvator-XS M3 with 4GB memory
* Renesas Salvator-XS H3 with 8GB memory
* Renesas Starter Kit Premiere (H3ULCB)
* Renesas Starter Kit Pro (M3ULCB)

# Building
## Requirements

1. Ubuntu 18.0+ or any other Linux distribution which is supported by Poky/OE
2. Development packages for Yocto. Refer to [Yocto
   manual](https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#brief-build-system-packages).
3. You need `Moulin` installed in your PC. Recommended way is to
   install it for your user only: `pip3 install --user
   git+https://github.com/xen-troops/moulin`. Make sure that your
   `PATH` environment variable includes `${HOME}/.local/bin`.
4. Ninja build system: `sudo apt install ninja-build` on Ubuntu

## Fetching

You can fetch/clone this whole repository, but you actually need only
one file from it: `prod-aos-rcar.yaml`. During build `moulin` will
fetch this repository again into `yocto/` directory. So, to avoid
possible confusion, we recommend to download only `prod-aos-rcar.yaml`:

```
# curl -O https://raw.githubusercontent.com/xen-troops/meta-xt-prod-aos-rcar/master/prod-aos-rcar.yaml
```

## Building

Moulin is used to generate Ninja build file: `moulin
prod-aos-rcar.yaml`. This project provides a number
of additional options. You can use check them with
`--help-config` command line option:

```
# moulin prod-aos-rcar.yaml --help-config
usage: moulin prod-aos-rcar.yaml
       [--MACHINE {h3ulcb-4x2g-ab,salvator-x-m3,salvator-xs-m3-2x4g,salvator-xs-h3,salvator-x-h3-4x2g}]

Config file description: Xen-Troops development setup for Renesas RCAR Gen3
hardware

optional arguments:
  --MACHINE {h3ulcb-4x2g-ab,salvator-x-m3,salvator-xs-m3-2x4g,salvator-xs-h3,salvator-x-h3-4x2g}
                        RCAR Gen3-based device
```

To build for AosBox use the following command line: `moulin prod-aos-rcar.yaml`.

Moulin will generate `build.ninja` file. After that - run `ninja` to
build the images. This will take some time and disk space, as it will
built 3 separate Yocto images. Depending on internet speed, this will
take 2-4 hours on Intel i7 with 32GB of RAM and 100 GB SSD.

## Creating SD card image

Image file can be created with `rouge` tool. This is a companion
application for `moulin`.

It can be invoked either as a standalone tool, or via Ninja.

### Creating image(s) via Ninja

Newer versions of `moulin` (>= 0.5) will generate additional Ninja targets:

 - `image-full`

Thus, you can just run `ninja image-full` or `ninja full.img` which
will generate the `full.img` in your build directory.

Then you can use `dd` to write this image to your SD card. Don't
forget `conv=sparse` option for `dd` to speed up writing.

### Using `rouge` in standalone mode

In this mode you can write image right to SD card. But it requires
additional options.

In standalone mode`rouge` accepts the same parameters like
`--MACHINE` as `moulin` does.

You can prepare image by running

```
# rouge prod-aos-rcar.yaml -i full
```

This will create file `full.img` in your current directory.

Also you can write image directly to a SD card by running

```
# sudo rouge prod-aos-rcar.yaml -i full -so /dev/sdX
```

**BE SURE TO PROVIDE CORRECT DEVICE NAME**. `rouge` have no
interactive prompts and will overwrite your device right away.
**ALL DATA WILL BE LOST**.

For more information about `rouge` check its
[manual](https://moulin.readthedocs.io/en/latest/rouge.html).
