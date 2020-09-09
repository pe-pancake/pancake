# PePe scripts

![Lint](https://github.com/pe-pancake/pancake/workflows/Lint/badge.svg)

## Initialize
```sh
# create a folder to hold source code
mkdir pe-pancake
cd pe-pancake

# clone scripts
git clone https://github.com/pe-pancake/pancake.git

# run initialization script
pancake/init
```

## Build script
The build script requires Bash as execution environment. To add the build script to your environment, source setup file.

```sh
source pancake/envsetup.bash
```

After that you will have access to the `pk` command.

### Usage

```sh
pk build
```

### Options

* `regenerate` or `r` — Regenerate kernel defconfig.
* `build` or `b` — Build ROM.
* `build-kernel` or `bk` — Build kernel + DTBO (bootimage).
* `sync` or `s` — Update source codes from remote repositories and apply patches.
