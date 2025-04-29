# Smart Robot - Bevy Experimental Project


> Bevy is a refreshingly simple data-driven game engine built in Rust.

<https://bevyengine.org/>

<https://github.com/bevyengine/bevy>


## Setup


Pre-requisites:

- Rust Toolchain
- Docker Engine / CLI
- Vulkan support (NVidia GPU)
- Wayland window system

...

Ubuntu 25.04 Plucky with NVidia GPU:

> WARNING: use with caution

[`setup-ubuntu2504.sh`](./setup-ubuntu2504.sh)

```sh
./setup-ubuntu2504.sh
```

<details>
<summary>Output.</summary>

```text
Install Rust Toolchain

Get:1 https://nvidia.github.io/libnvidia-container/stable/deb/amd64  InRelease [1477 B]
Hit:2 https://download.docker.com/linux/ubuntu plucky InRelease
Hit:4 http://archive.ubuntu.com/ubuntu plucky InRelease
Hit:5 http://archive.ubuntu.com/ubuntu plucky-updates InRelease
Hit:7 http://archive.ubuntu.com/ubuntu plucky-security InRelease
Hit:8 http://archive.ubuntu.com/ubuntu plucky-backports InRelease
Fetched 1477 B in 1s (1082 B/s)
All packages are up to date.
ca-certificates is already the newest version (20241223).
curl is already the newest version (8.12.1-3ubuntu1).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0
info: downloading installer
warn: It looks like you have an existing rustup settings file at:
warn: /home/cavani/.rustup/settings.toml
warn: Rustup will install the default toolchain as specified in the settings file,
warn: instead of the one inferred from the default host triple.
info: profile set to 'default'
info: default host triple is x86_64-unknown-linux-gnu
warn: Updating existing toolchain, profile choice will be ignored
info: syncing channel updates for 'stable-x86_64-unknown-linux-gnu'
info: default toolchain set to 'stable-x86_64-unknown-linux-gnu'

  stable-x86_64-unknown-linux-gnu unchanged - rustc 1.86.0 (05f9846f8 2025-03-31)


Rust is installed now. Great!

To get started you may need to restart your current shell.
This would reload your PATH environment variable to include
Cargo's bin directory ($HOME/.cargo/bin).

To configure your current shell, you need to source
the corresponding env file under $HOME/.cargo.

This is usually done by running one of the following (note the leading DOT):
. "$HOME/.cargo/env"            # For sh/bash/zsh/ash/dash/pdksh
source "$HOME/.cargo/env.fish"  # For fish
source "$HOME/.cargo/env.nu"    # For nushell

Install Compiler (clang / lld)

clang is already the newest version (1:20.0-63ubuntu1).
lld is already the newest version (1:20.0-63ubuntu1).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0

Install Build Dependencies

pkg-config is already the newest version (1.8.1-4).
libasound2-dev is already the newest version (1.2.13-1build1).
libudev-dev is already the newest version (257.4-1ubuntu3).
libx11-dev is already the newest version (2:1.8.10-2).
libxkbcommon-x11-0 is already the newest version (1.7.0-2).
libwayland-dev is already the newest version (1.23.1-3).
libxkbcommon-dev is already the newest version (1.7.0-2).
mesa-vulkan-drivers is already the newest version (25.0.3-1ubuntu2).
mesa-utils is already the newest version (9.0.0-2).
vulkan-tools is already the newest version (1.4.304.0+dfsg1-1).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0

Install Docker Engine

Hit:1 https://download.docker.com/linux/ubuntu plucky InRelease
Get:2 https://nvidia.github.io/libnvidia-container/stable/deb/amd64  InRelease [1477 B]
Hit:4 http://archive.ubuntu.com/ubuntu plucky InRelease
Hit:5 http://archive.ubuntu.com/ubuntu plucky-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu plucky-security InRelease
Hit:7 http://archive.ubuntu.com/ubuntu plucky-backports InRelease
Fetched 1477 B in 2s (823 B/s)
All packages are up to date.
docker-ce is already the newest version (5:28.1.1-1~ubuntu.25.04~plucky).
docker-ce-cli is already the newest version (5:28.1.1-1~ubuntu.25.04~plucky).
containerd.io is already the newest version (1.7.27-1).
docker-buildx-plugin is already the newest version (0.23.0-1~ubuntu.25.04~plucky).
docker-compose-plugin is already the newest version (2.35.1-1~ubuntu.25.04~plucky).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0

Install QEMU (Docker uses to run ARM64 on AMD64)

qemu-user-static is already the newest version (1:9.2.1+ds-1ubuntu5).
binfmt-support is already the newest version (2.2.2-7).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0

Install NVidia Container Toolkit

Hit:1 https://download.docker.com/linux/ubuntu plucky InRelease
Get:2 https://nvidia.github.io/libnvidia-container/stable/deb/amd64  InRelease [1477 B]
Hit:4 http://archive.ubuntu.com/ubuntu plucky InRelease
Hit:5 http://archive.ubuntu.com/ubuntu plucky-updates InRelease
Hit:7 http://archive.ubuntu.com/ubuntu plucky-security InRelease
Hit:9 http://archive.ubuntu.com/ubuntu plucky-backports InRelease
Fetched 1477 B in 1s (1025 B/s)
All packages are up to date.
nvidia-driver-570 is already the newest version (570.133.07-0ubuntu2).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0
nvidia-container-toolkit is already the newest version (1.17.6-1).
Summary:
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0
```
</details>


## Development


### Project


```sh
# run tests from `tests` modules
make test

# run lint on rs files in `src` directory
make lint

# format rs files
make format

# build all targets
make build

# remove builds
make clean
```


### Execution


```sh
# Ubuntu 25.04 x86_64 (development)

# Build Docker Image `smartrobot-bevy-devel:ubuntu-amd64`
make docker-build-ubuntu-amd64

# Execute `cargo run` in a container based on `smartrobot-bevy-devel:ubuntu-amd64`
# (open a window using Wayland)
make docker-run-ubuntu-amd64
make docker-run-ubuntu-amd64-nvidia

# Alias for build and run with ubuntu-amd64
# (open a window using Wayland)
make docker-ubuntu-amd64
make docker-ubuntu-amd64-nvidia


# Debian 12 ARM64 (emulator) - Raspberry Pi

# Build Docker Image `smartrobot-bevy-devel:debian-arm64`
make docker-build-debian-arm64

# Execute `cargo run` in a container based on `smartrobot-bevy-devel:debian-arm64`
# (open a window using Wayland)
make docker-run-debian-arm64

# Alias for build and run with debian-arm64
# (open a window using Wayland)
make docker-debian-arm64
```


## Book of Dev


[README](./dev-book/README.md)
