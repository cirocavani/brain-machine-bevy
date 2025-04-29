# Smart Robot - Bevy Experimental Project


> Bevy is a refreshingly simple data-driven game engine built in Rust.

<https://bevyengine.org/>

<https://github.com/bevyengine/bevy>


## Setup


Pre-requisites:

- Rust Toolchain
- Docker Engine / CLI
- Wayland window system
- Vulkan support


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

# Alias for build and run with ubuntu-amd64
# (open a window using Wayland)
make docker-ubuntu-amd64


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
