# Bevy Quick Start

Based on:

<https://bevyengine.org/learn/quick-start/>


Development Host:

- Ubuntu 25.04 Plucky
- Gnome 48 on Wayland
- CPU Intel Core 7 x86_64
- GPU Integrated Intel Graphics
- GPU Discrete NVIDIA GeForce MX570 A 2GB

Targets:

- Ubuntu 25.04 AMD64 (x86_64) -> Development Host
- Debian 12 ARM64 (aarch64) -> Raspberry Pi


## Quick Start Project

```sh
# Basic Utilities

sudo apt install -y \
--no-install-recommends \
ca-certificates \
curl \
gpg \
unzip \
sed



# GPU Vulkan

# sudo apt install -y --no-install-recommends nvidia-driver-570

sudo apt install -y --no-install-recommends vulkan-tools


vulkaninfo --summary

# ==========
# VULKANINFO
# ==========
# 
# Vulkan Instance Version: 1.4.304
# 
# 
# Instance Extensions: count = 25
# -------------------------------
# VK_EXT_acquire_drm_display             : extension revision 1
# VK_EXT_acquire_xlib_display            : extension revision 1
# VK_EXT_debug_report                    : extension revision 10
# VK_EXT_debug_utils                     : extension revision 2
# VK_EXT_direct_mode_display             : extension revision 1
# VK_EXT_display_surface_counter         : extension revision 1
# VK_EXT_headless_surface                : extension revision 1
# VK_EXT_surface_maintenance1            : extension revision 1
# VK_EXT_swapchain_colorspace            : extension revision 5
# VK_KHR_device_group_creation           : extension revision 1
# VK_KHR_display                         : extension revision 23
# VK_KHR_external_fence_capabilities     : extension revision 1
# VK_KHR_external_memory_capabilities    : extension revision 1
# VK_KHR_external_semaphore_capabilities : extension revision 1
# VK_KHR_get_display_properties2         : extension revision 1
# VK_KHR_get_physical_device_properties2 : extension revision 2
# VK_KHR_get_surface_capabilities2       : extension revision 1
# VK_KHR_portability_enumeration         : extension revision 1
# VK_KHR_surface                         : extension revision 25
# VK_KHR_surface_protected_capabilities  : extension revision 1
# VK_KHR_wayland_surface                 : extension revision 6
# VK_KHR_xcb_surface                     : extension revision 6
# VK_KHR_xlib_surface                    : extension revision 6
# VK_LUNARG_direct_driver_loading        : extension revision 1
# VK_NV_display_stereo                   : extension revision 1
# 
# Instance Layers: count = 4
# --------------------------
# VK_LAYER_INTEL_nullhw       INTEL NULL HW                1.1.73   version 1
# VK_LAYER_MESA_device_select Linux device selection layer 1.4.303  version 1
# VK_LAYER_MESA_overlay       Mesa Overlay layer           1.4.303  version 1
# VK_LAYER_NV_optimus         NVIDIA Optimus layer         1.4.303  version 1
# 
# Devices:
# ========
# GPU0:
#         apiVersion         = 1.4.305
#         driverVersion      = 25.0.3
#         vendorID           = 0x8086
#         deviceID           = 0xa7ac
#         deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
#         deviceName         = Intel(R) Graphics (RPL-U)
#         driverID           = DRIVER_ID_INTEL_OPEN_SOURCE_MESA
#         driverName         = Intel open-source Mesa driver
#         driverInfo         = Mesa 25.0.3-1ubuntu2
#         conformanceVersion = 1.4.0.0
#         deviceUUID         = 8680aca7-0400-0000-0002-000000000000
#         driverUUID         = b7bfe4ab-94df-c0d4-616d-43a427c11fca
# GPU1:
#         apiVersion         = 1.4.303
#         driverVersion      = 570.133.7.0
#         vendorID           = 0x10de
#         deviceID           = 0x25aa
#         deviceType         = PHYSICAL_DEVICE_TYPE_DISCRETE_GPU
#         deviceName         = NVIDIA GeForce MX570 A
#         driverID           = DRIVER_ID_NVIDIA_PROPRIETARY
#         driverName         = NVIDIA
#         driverInfo         = 570.133.07
#         conformanceVersion = 1.4.1.0
#         deviceUUID         = ffacb06a-ba56-5cc1-58da-90cadf3cc4e0
#         driverUUID         = a312329b-a338-5885-bebf-8b95ca9ae741
# GPU2:
#         apiVersion         = 1.4.305
#         driverVersion      = 0.0.1
#         vendorID           = 0x10005
#         deviceID           = 0x0000
#         deviceType         = PHYSICAL_DEVICE_TYPE_CPU
#         deviceName         = llvmpipe (LLVM 19.1.7, 256 bits)
#         driverID           = DRIVER_ID_MESA_LLVMPIPE
#         driverName         = llvmpipe
#         driverInfo         = Mesa 25.0.3-1ubuntu2 (LLVM 19.1.7)
#         conformanceVersion = 1.3.1.1
#         deviceUUID         = 6d657361-3235-2e30-2e33-2d3175627500
#         driverUUID         = 6c6c766d-7069-7065-5555-494400000000



# Rust Toolchain


curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | \
sh -s -- --default-toolchain stable -y

. "$HOME/.cargo/env"


cargo version

# cargo 1.86.0 (adf9b6ad1 2025-02-28)


# https://github.com/cargo-bins/cargo-binstall

curl --proto "=https" --tlsv1.2 -sSfL https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | \
bash

cargo binstall -V

# 1.12.3



# Project Setup


mkdir smartrobot-bevy

cd smartrobot-bevy

cargo init

sed -i 's/version = "0.1.0"/version = "0.0.1"/' Cargo.toml

echo 'use_field_init_shorthand = true
newline_style = "Unix"
style_edition = "2024"' \
> rustfmt.toml


# Add Bevy as a dependency

# https://github.com/bevyengine/bevy/blob/main/docs/linux_dependencies.md#ubuntu
# https://bevyengine.org/learn/quick-start/getting-started/setup/#dynamic-linking
# https://bevyengine.org/learn/quick-start/getting-started/setup/#improve-runtime-performance-optional


sudo apt install -y \
--no-install-recommends \
pkg-config \
libasound2-dev \
libudev-dev \
libx11-dev \
libxkbcommon-x11-0 \
libwayland-dev \
libxkbcommon-dev


cargo add bevy log

echo '
[features]
wayland = ["bevy/wayland"]
dev = ["bevy-dev", "log-max"]
bevy-dev = ["bevy/dynamic_linking"]
log-max = ["log/max_level_debug", "log/release_max_level_warn"]
' \
>> Cargo.toml



# Compile with Performance Optimizations

# https://bevyengine.org/learn/quick-start/getting-started/setup/#compile-with-performance-optimizations


echo '# Enable a small amount of optimization in the dev profile.
[profile.dev]
opt-level = 1

# Enable a large amount of optimization in the dev profile for dependencies.
[profile.dev.package."*"]
opt-level = 3

# Enable more optimization in the release profile at the cost of compile time.
[profile.release]
# Strip all symbols and debugging information from the binary to slightly reduce file size.
# strip = "debuginfo"
strip = true
panic = "abort"

[profile.release-lto]
# Default to release profile values.
inherits = "release"
# Compile the entire crate as one unit.
# Slows compile times, marginal improvements.
codegen-units = 1
# Do a second optimization pass over the entire program, including dependencies.
# Slows compile times, marginal improvements.
lto = true

# Optimize for size in the wasm-release profile to reduce load times and bandwidth usage on web.
[profile.wasm-release]
# Default to release-lto profile values.
inherits = "release-lto"
# Optimize with size in mind (also try "z", sometimes it is better).
# Slightly slows compile times, great improvements to file size and runtime performance.
opt-level = "s"
' \
>> Cargo.toml



# Alternative Linkers

# https://bevyengine.org/learn/quick-start/getting-started/setup/#compile-with-performance-optimizations


# - Ubuntu 25.04 x86_64

sudo apt install -y \
--no-install-recommends \
clang \
lld


clang --version

# Ubuntu clang version 20.1.2 (0ubuntu1)
# Target: x86_64-pc-linux-gnu
# Thread model: posix
# InstalledDir: /usr/lib/llvm-20/bin

# - Raspberry Pi OS (Debian 12)

sudo apt install -y \
--no-install-recommends \
clang-19 \
lld-19

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-19 100
# sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-19 100


clang --version

# Debian clang version 19.1.4 (1~deb12u1)
# Target: aarch64-unknown-linux-gnu
# Thread model: posix
# InstalledDir: /usr/lib/llvm-19/bin


# - Cargo Config

mkdir -p .cargo/

echo '[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]

[target.aarch64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]
' \
> .cargo/config.toml



# Quick Start Example Code


echo 'use bevy::prelude::*;

pub struct HelloPlugin;

#[derive(Component)]
struct Person;

#[derive(Component)]
struct Name(String);

#[derive(Resource)]
struct GreetTimer(Timer);

impl Plugin for HelloPlugin {
    fn build(&self, app: &mut App) {
        app.insert_resource(GreetTimer(Timer::from_seconds(2.0, TimerMode::Repeating)));
        app.add_systems(Startup, add_people);
        app.add_systems(Update, (update_people, greet_people).chain());
    }
}

fn add_people(mut commands: Commands) {
    commands.spawn((Person, Name("Elaina Proctor".to_string())));
    commands.spawn((Person, Name("Renzo Hume".to_string())));
    commands.spawn((Person, Name("Zayna Nieves".to_string())));
}

fn update_people(mut query: Query<&mut Name, With<Person>>) {
    for mut name in &mut query {
        if name.0 == "Elaina Proctor" {
            name.0 = "Elaina Hume".to_string();
            break; // We don'"'"'t need to change any other names.
        }
    }
}

fn greet_people(time: Res<Time>, mut timer: ResMut<GreetTimer>, query: Query<&Name, With<Person>>) {
    // update our timer with the time elapsed since the last update
    // if that caused the timer to finish, we say hello to everyone
    if timer.0.tick(time.delta()).just_finished() {
        for name in &query {
            println!("hello {}!", name.0);
        }
    }
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_plugins(HelloPlugin)
        .run();
}' \
> src/main.rs


cargo run --features dev,wayland

# -> [Output Dev]
```

<details>
<summary>Output Dev.</summary>

```text
cargo run --features dev,wayland
    Finished `dev` profile [optimized + debuginfo] target(s) in 6m 39s
     Running `target/debug/smartrobot-bevy`
2025-04-28T22:53:41.224703Z  INFO bevy_render::renderer: AdapterInfo { name: "NVIDIA GeForce MX570 A", vendor: 4318, device: 9642, device_type: DiscreteGpu, driver: "NVIDIA", driver_info: "570.133.07", backend: Vulkan }
2025-04-28T22:53:41.520430Z  INFO bevy_render::batching::gpu_preprocessing: GPU preprocessing is fully supported on this device.
2025-04-28T22:53:41.572693Z  INFO bevy_winit::system: Creating new window App (0v1)
2025-04-28T22:53:41.755552Z  WARN sctk_adwaita::buttons: Ignoring unknown button type:
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
2025-04-28T22:53:47.700346Z  INFO bevy_window::system: No windows are open, exiting
2025-04-28T22:53:47.701109Z  INFO bevy_winit::system: Closing window 0v1
```
</details>


## Docker Development


Targets:

- Ubuntu 25.04 AMD64 (x86_64) -> Development Host
- Debian 12 ARM64 (aarch64) -> Raspberry Pi

```sh
# Docker Install

# https://docs.docker.com/engine/install/ubuntu/

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg --yes

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu plucky stable' | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update


sudo apt install -y \
--no-install-recommends \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

sudo usermod -aG docker $USER

newgrp docker


# Ubuntu 25.04 AMD64 -> development

# (Optional - initial empty container)
# WARNING: files are created with owner id 0 (root) on project folder

docker run \
--rm \
-it \
--platform linux/amd64 \
-e DEBIAN_FRONTEND=noninteractive \
-e CARGO_TARGET_DIR=/target/x86_64-unknown-linux-gnu \
-v $PWD:/project \
-w /project \
ubuntu:25.04

# (container shell)
# apt ...
# cargo ...


# Project Devel Image

docker build \
--platform linux/amd64 \
--build-arg USER_ID=`id -u` \
--build-arg GROUP_ID=`id -g` \
-t smartrobot-bevy-ubuntu:latest \
-f docker/ubuntu/Dockerfile \
.

docker run \
--rm \
-it \
--platform linux/amd64 \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
-e CARGO_TARGET_DIR=/home/user/project/target/x86_64-unknown-linux-gnu \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
smartrobot-bevy-ubuntu:latest \
cargo run --features dev,wayland

# -> [Output ubuntu-amd64 (Docker)]


file -b target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy

# ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=3a524fd5a08f8a44d1449f0ef95d6841a629eee3, with debug_info, not stripped

ls -alh target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 4.2M Apr 28 12:58 target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy


# Debian 12 ARM64 -> Raspberry Pi

# Docker Host (Ubuntu 25.04 AMD64) running ARM64 container
# docker run --platform linux/arm64

sudo apt install -y \
--no-install-recommends \
qemu-user-static \
binfmt-support


# (Optional - initial empty container)
# WARNING: files are created with owner id 0 (root) on project folder

docker run \
--rm \
-it \
--platform linux/arm64 \
-e DEBIAN_FRONTEND=noninteractive \
-e CARGO_TARGET_DIR=/target/aarch64-unknown-linux-gnu \
-v $PWD:/project \
-w /project \
debian:12

# (container shell)
# apt ...
# cargo ...


# Project Devel Image

docker build \
--platform linux/arm64 \
--build-arg USER_ID=`id -u` \
--build-arg GROUP_ID=`id -g` \
-t smartrobot-bevy-debian:latest \
-f docker/debian/Dockerfile \
.

docker run \
--rm \
-it \
--platform linux/arm64 \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
-e CARGO_TARGET_DIR=/home/user/project/target/aarch64-unknown-linux-gnu \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
smartrobot-bevy-debian:latest \
cargo run --features dev,wayland

# -> [Output debian-arm64 (Docker)]


file -b target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy

# ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, BuildID[sha1]=5b8b35673e515c67fad059f50b4fe5b7a4109b36, with debug_info, not stripped

ls -alh target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 4.2M Apr 28 14:37 target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy
```

<details>
<summary>Output ubuntu-amd64 (Docker).</summary>

```text
cargo run --features dev,wayland
    Finished `dev` profile [optimized + debuginfo] target(s) in 0.61s
     Running `target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy`
2025-04-28T22:35:03.808071Z  INFO bevy_render::renderer: AdapterInfo { name: "llvmpipe (LLVM 19.1.7, 256 bits)", vendor: 65541, device: 0, device_type: Cpu, driver: "llvmpipe", driver_info: "Mesa 25.0.3-1ubuntu2 (LLVM 19.1.7)", backend: Vulkan }
2025-04-28T22:35:03.808423Z  WARN bevy_render::renderer: The selected adapter is using a driver that only supports software rendering. This is likely to be very slow. See https://bevyengine.org/learn/errors/b0006/
ALSA lib confmisc.c:855:(parse_card) cannot find card '0'
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_card_inum returned error: No such file or directory
ALSA lib confmisc.c:422:(snd_func_concat) error evaluating strings
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1342:(snd_func_refer) error evaluating name
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5728:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2722:(snd_pcm_open_noupdate) Unknown PCM default
2025-04-28T22:35:04.012204Z  WARN bevy_audio::audio_output: No audio device found.
2025-04-28T22:35:04.053730Z  INFO bevy_render::batching::gpu_preprocessing: GPU preprocessing is fully supported on this device.
2025-04-28T22:35:04.308301Z  INFO bevy_winit::system: Creating new window App (0v1)
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
2025-04-28T22:35:13.835446Z  INFO bevy_window::system: No windows are open, exiting
2025-04-28T22:35:13.836019Z  INFO bevy_winit::system: Closing window 0v1
```
</details>

<details>
<summary>Output debian-arm64 (Docker).</summary>

```text
cargo run --features dev,wayland
    Finished `dev` profile [optimized + debuginfo] target(s) in 2.68s
     Running `target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy`
2025-04-28T22:35:33.225543Z  INFO bevy_render::renderer: AdapterInfo { name: "llvmpipe (LLVM 15.0.6, 128 bits)", vendor: 65541, device: 0, device_type: Cpu, driver: "llvmpipe", driver_info: "Mesa 22.3.6 (LLVM 15.0.6)", backend: Vulkan }
2025-04-28T22:35:33.229808Z  WARN bevy_render::renderer: The selected adapter is using a driver that only supports software rendering. This is likely to be very slow. See https://bevyengine.org/learn/errors/b0006/
ALSA lib confmisc.c:855:(parse_card) cannot find card '0'
ALSA lib conf.c:5180:(_snd_config_evaluate) function snd_func_card_inum returned error: No such file or directory
ALSA lib confmisc.c:422:(snd_func_concat) error evaluating strings
ALSA lib conf.c:5180:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1334:(snd_func_refer) error evaluating name
ALSA lib conf.c:5180:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5703:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2666:(snd_pcm_open_noupdate) Unknown PCM default
2025-04-28T22:35:35.373290Z  WARN bevy_audio::audio_output: No audio device found.
2025-04-28T22:35:35.839887Z  INFO bevy_render::batching::gpu_preprocessing: GPU preprocessing is fully supported on this device.
2025-04-28T22:35:36.029094Z  INFO bevy_winit::system: Creating new window App (0v1)
2025-04-28T22:35:36.127077Z ERROR sctk_adwaita::config: XDG Settings Portal did not return response in time: timeout: 100ms, key: color-scheme
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
2025-04-28T22:35:46.867140Z  INFO bevy_window::system: No windows are open, exiting
2025-04-28T22:35:46.877311Z  INFO bevy_winit::system: Closing window 0v1
```
</details>


## Running on Docker Ubuntu using NVIDIA GPU


NVIDIA Container Toolkit

<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html>

```sh
# -> Using Docker Development Ubuntu 25.04 AMD64 Image


# NVIDIA Container Toolkit

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg --yes

echo 'deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /' | \
sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

sudo apt update

sudo apt install -y --no-install-recommends nvidia-driver-570
sudo apt install -y --no-install-recommends nvidia-container-toolkit

# reboot after driver installation


docker run \
--rm \
-it \
--platform linux/amd64 \
--runtime nvidia \
--gpus all \
--device /dev/dri \
--group-add $(getent group video | cut -d ':' -f 3) \
--group-add $(getent group render | cut -d ':' -f 3) \
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
-e CARGO_TARGET_DIR=/home/user/project/target/x86_64-unknown-linux-gnu \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
smartrobot-bevy-ubuntu:latest \
cargo run --features dev,wayland

# -> [Output ubuntu-amd64 (NVIDIA)]
```

<details>
<summary>Output ubuntu-amd64 (NVIDIA).</summary>

```text
cargo run --features dev,wayland
    Finished `dev` profile [optimized + debuginfo] target(s) in 0.18s
     Running `target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy`
2025-04-29T13:26:28.847748Z  INFO bevy_render::renderer: AdapterInfo { name: "NVIDIA GeForce MX570 A", vendor: 4318, device: 9642, device_type: DiscreteGpu, driver: "NVIDIA", driver_info: "570.133.07", backend: Vulkan }
ALSA lib confmisc.c:855:(parse_card) cannot find card '0'
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_card_inum returned error: No such file or directory
ALSA lib confmisc.c:422:(snd_func_concat) error evaluating strings
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1342:(snd_func_refer) error evaluating name
ALSA lib conf.c:5205:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5728:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2722:(snd_pcm_open_noupdate) Unknown PCM default
2025-04-29T13:26:29.093659Z  WARN bevy_audio::audio_output: No audio device found.
2025-04-29T13:26:29.108755Z  INFO bevy_render::batching::gpu_preprocessing: GPU preprocessing is fully supported on this device.
2025-04-29T13:26:29.140082Z  INFO bevy_winit::system: Creating new window App (0v1)
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
hello Elaina Hume!
hello Renzo Hume!
hello Zayna Nieves!
2025-04-29T13:26:35.212520Z  INFO bevy_window::system: No windows are open, exiting
2025-04-29T13:26:35.212909Z  INFO bevy_winit::system: Closing window 0v1
```
</details>


## Running on Raspbery Pi


(Vulkan error)

```sh
# Raspbery Pi OS -> Debian 12 ARM64

cargo run --features dev,bevy/x11
```

<details>
<summary>Output Dev (RPi).</summary>

```text
cargo run
    Finished `dev` profile [optimized + debuginfo] target(s) in 22m 55s
     Running `target/debug/smartrobot-bevy`
libEGL warning: DRI3: Screen seems not DRI3 capable
libEGL warning: DRI3: Screen seems not DRI3 capable
2025-04-29T13:23:21.515192Z  INFO bevy_render::renderer: AdapterInfo { name: "V3D 7.1.7.0", vendor: 5348, device: 1433410611, device_type: IntegratedGpu, driver: "V3DV Mesa", driver_info: "Mesa 24.2.8-1~bpo12+rpt2", backend: Vulkan }
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dsnoop.c:540:(snd_pcm_dsnoop_open) The dsnoop plugin supports only capture stream
ALSA lib pcm_dsnoop.c:540:(snd_pcm_dsnoop_open) The dsnoop plugin supports only capture stream
ALSA lib pcm_asym.c:105:(_snd_pcm_asym_open) capture slave is not defined
ALSA lib pcm_asym.c:105:(_snd_pcm_asym_open) capture slave is not defined
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:972:(snd_pcm_dmix_open) The dmix plugin supports only playback stream
ALSA lib pcm_asym.c:105:(_snd_pcm_asym_open) capture slave is not defined
ALSA lib pcm_asym.c:105:(_snd_pcm_asym_open) capture slave is not defined
ALSA lib pcm_dmix.c:999:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:972:(snd_pcm_dmix_open) The dmix plugin supports only playback stream
2025-04-29T13:23:21.834727Z  INFO bevy_render::batching::gpu_preprocessing: Some GPU preprocessing are limited on this device.
2025-04-29T13:23:21.873529Z  WARN bevy_pbr::ssao: ScreenSpaceAmbientOcclusionPlugin not loaded. GPU lacks support: Limits::max_storage_textures_per_shader_stage is less than 5.
2025-04-29T13:23:21.873721Z ERROR wgpu::backend::wgpu_core: Handling wgpu errors as fatal by default

thread 'main' panicked at /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/wgpu-24.0.3/src/backend/wgpu_core.rs:1079:26:
wgpu error: Validation Error

Caused by:
  In Device::create_bind_group_layout, label = 'build mesh uniforms GPU early occlusion culling bind group layout'
    Too many bindings of type StorageBuffers in Stage ShaderStages(COMPUTE), limit is 8, count was 9. Check the limit `max_storage_buffers_per_shader_stage` passed to `Adapter::request_device`


note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
</details>


## WebAssembly

<https://github.com/bevyengine/bevy/blob/v0.16.0/examples/README.md#wasm>


```sh
rustup target add wasm32-unknown-unknown

cargo binstall -y wasm-bindgen-cli

wasm-bindgen --version

# wasm-bindgen 0.2.100


cargo build \
--profile wasm-release \
--target wasm32-unknown-unknown \
--features log-max

ls -alh target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

# -rwxrwxr-x 2 cavani cavani 31M Apr 29 14:11 target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm


rm -rf web/

wasm-bindgen \
--out-name smartrobot_bevy \
--out-dir web/ \
--target web \
target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

ls -alh web/

# total 28M
# drwxrwxr-x  2 cavani cavani 4.0K Apr 29 14:26 ./
# drwxrwxr-x 10 cavani cavani 4.0K Apr 29 14:26 ../
# -rw-rw-r--  1 cavani cavani 2.1K Apr 29 14:26 smartrobot_bevy.d.ts
# -rw-rw-r--  1 cavani cavani  97K Apr 29 14:26 smartrobot_bevy.js
# -rw-rw-r--  1 cavani cavani  27M Apr 29 14:26 smartrobot_bevy_bg.wasm
# -rw-rw-r--  1 cavani cavani 1.2K Apr 29 14:26 smartrobot_bevy_bg.wasm.d.ts

echo '<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Smart Robot</title>
  </head>
  <script type="module">
    import init from "./smartrobot_bevy.js"
    init()
  </script>
</html>' \
> web/index.html


cargo binstall -y simple-http-server

simple-http-server --version

# Simple HTTP(s) Server 0.6.12


simple-http-server -i web/

# -> [Output http-server]


# Google Chrome

# (Ubuntu Snap Firefox does not use NVIDIA discrete CPU by default)
# (Chrome can default to NVIDIA discrete GPU with environment variable configuration)

curl --proto '=https' --tlsv1.2 -sSfLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt install -f

google-chrome --version

# Google Chrome 136.0.7103.59


export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

google-chrome \
--no-default-browser-check \
--no-first-run \
--disable-sync \
--disable-translate \
--disable-background-networking \
--safebrowsing-disable-auto-update \
--safebrowsing-disable-download-protection \
--metrics-recording-only \
--enable-logging \
--log-level=1 \
--full-memory-crash-report \
--auto-open-devtools-for-tabs \
--app=http://127.0.0.1:8000/

# -> [Output Chrome Console]


google-chrome chrome://gpu/

# -> [Output Chrome GPU info]
```

<details>
<summary>Output Web Server</summary>

```text
     Index: enabled, Cache: enabled, Cors: disabled, Coop: disabled, Coep: disabled, Range: enabled, Sort: enabled, Threads: 3
          Upload: disabled, CSRF Token:
          Auth: disabled, Compression: disabled
         https: disabled, Cert: , Cert-Password:
          Root: /home/cavani/Workspace/smartrobot-bevy/web,
    TryFile404:
       Address: http://0.0.0.0:8000
    ======== [2025-04-20 10:34:14] ========
[2025-04-30 10:41:41] - 127.0.0.1 - 200 - GET /
[2025-04-30 10:41:41] - 127.0.0.1 - 200 - GET /smartrobot_bevy.js
[2025-04-30 10:41:41] - 127.0.0.1 - 200 - GET /smartrobot_bevy_bg.wasm
[2025-04-30 10:41:41] - 127.0.0.1 - 404 - GET /favicon.ico
[2025-04-30 10:41:55] - 127.0.0.1 - 404 - GET /.well-known/appspecific/com.chrome.devtools.json
```
</details>

<details>
<summary>Output Chrome Console</summary>

```text
smartrobot_bevy.js:1589 The AudioContext was not allowed to start. It must be resumed (or created) after a user gesture on the page. https://goo.gl/7K7WLu
(anonymous) @ smartrobot_bevy.js:1589
smartrobot_bevy.js:1229 INFO /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/system.rs:66 Creating new window App (0v1)
smartrobot_bevy.js:1229 INFO /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/src/renderer/mod.rs:200 AdapterInfo { name: "ANGLE (NVIDIA Corporation, NVIDIA GeForce MX570 A/PCIe/SSE2, OpenGL 4.5.0)", vendor: 4318, device: 0, device_type: Other, driver: "", driver_info: "WebGL 2.0 (OpenGL ES 3.0 Chromium)", backend: Gl }
smartrobot_bevy.js:1229 INFO /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/src/batching/gpu_preprocessing.rs:1126 GPU preprocessing is not supported on this device. Falling back to CPU preprocessing.
smartrobot_bevy.js:1229 WARN /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_core_pipeline-0.16.0/src/oit/resolve/mod.rs:83 OrderIndependentTransparencyPlugin not loaded. GPU lacks support: DownlevelFlags::FRAGMENT_WRITABLE_STORAGE.
smartrobot_bevy.js:1229 WARN /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_pbr-0.16.0/src/ssao/mod.rs:92 ScreenSpaceAmbientOcclusionPlugin not loaded. GPU lacks support: TextureFormat::R16Float does not support TextureUsages::STORAGE_BINDING.
smartrobot_bevy.js:1229 WARN /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_pbr-0.16.0/src/atmosphere/mod.rs:170 AtmospherePlugin not loaded. GPU lacks support for compute shaders.
smartrobot_bevy.js:1229 INFO /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_core_pipeline-0.16.0/src/dof/mod.rs:824 Disabling depth of field on this platform because depth textures aren't supported correctly
smartrobot_bevy.js:1716 The AudioContext was not allowed to start. It must be resumed (or created) after a user gesture on the page. https://goo.gl/7K7WLu
(anonymous) @ smartrobot_bevy.js:1716
smartrobot_bevy.js:1716 The AudioContext was not allowed to start. It must be resumed (or created) after a user gesture on the page. https://goo.gl/7K7WLu
(anonymous) @ smartrobot_bevy.js:1716
```
</details>

<details>
<summary>Output Chrome GPU info</summary>

```text
Graphics Feature Status
=======================
*   Canvas: Hardware accelerated
*   Direct Rendering Display Compositor: Disabled
*   Compositing: Hardware accelerated
*   Multiple Raster Threads: Enabled
*   OpenGL: Enabled
*   Rasterization: Hardware accelerated
*   Raw Draw: Disabled
*   Skia Graphite: Disabled
*   Video Decode: Hardware accelerated
*   Video Encode: Software only. Hardware acceleration disabled
*   Vulkan: Disabled
*   WebGL: Hardware accelerated
*   WebGL2: Hardware accelerated
*   WebGPU: Disabled
*   WebNN: Disabled

...

GPU0                            : VENDOR= 0x10de, DEVICE=0x25aa, DRIVER_VENDOR=NVIDIA, DRIVER_VERSION=570.133.07 *ACTIVE*
GPU1                            : VENDOR= 0x8086, DEVICE=0xa7ac
Optimus                         : true
Display type                    : ANGLE_OPENGL
GL_VENDOR                       : Google Inc. (NVIDIA Corporation)
GL_RENDERER                     : ANGLE (NVIDIA Corporation, NVIDIA GeForce MX570 A/PCIe/SSE2, OpenGL 4.5.0 NVIDIA 570.133.07)
GL_VERSION                      : OpenGL ES 2.0.0 (ANGLE 2.1.25160 git hash: ecc378cc6110)

...

Driver Bug Workarounds
======================
*   disable_discard_framebuffer
*   enable_webgl_timer_query_extensions
*   exit_on_context_lost
*   force_cube_complete
*   init_gl_position_in_vertex_shader
*   unpack_overlapping_rows_separately_unpack_buffer
*   disabled_extension_GL_KHR_blend_equation_advanced
*   disabled_extension_GL_KHR_blend_equation_advanced_coherent
*   disabled_extension_GL_MESA_framebuffer_flip_y

Problems Detected
=================
*   WebGPU has been disabled via blocklist or the command line.
    Disabled Features: webgpu

*   Accelerated video encode has been disabled, either via blocklist, about:flags or the command line.
    Disabled Features: video_encode

*   Program link fails in NVIDIA Linux if gl_Position is not set:
    (http://crbug.com/286468)
    Applied Workarounds: init_gl_position_in_vertex_shader

*   NVIDIA fails glReadPixels from incomplete cube map texture:
    (http://crbug.com/518889)
    Applied Workarounds: force_cube_complete

*   Framebuffer discarding can hurt performance on non-tilers:
    (http://crbug.com/570897)
    Applied Workarounds: disable_discard_framebuffer

*   Unpacking overlapping rows from unpack buffers is unstable on NVIDIA GL driver:
    (http://crbug.com/596774)
    Applied Workarounds: unpack_overlapping_rows_separately_unpack_buffer

*   Disable KHR_blend_equation_advanced until cc shaders are updated:
    (http://crbug.com/661715)
    Applied Workarounds: disable(GL_KHR_blend_equation_advanced),
        disable(GL_KHR_blend_equation_advanced_coherent)

*   Expose WebGL's disjoint_timer_query extensions on platforms with site isolation:
    (http://crbug.com/808744), (http://crbug.com/870491)
    Applied Workarounds: enable_webgl_timer_query_extensions

*   Some drivers can't recover after OUT_OF_MEM and context lost:
    (http://crbug.com/893177)
    Applied Workarounds: exit_on_context_lost

*   Disable GL_MESA_framebuffer_flip_y for desktop GL:
    (http://crbug.com/964010)
    Applied Workarounds: disable(GL_MESA_framebuffer_flip_y)

...
```
</details>


## Android

<https://github.com/bevyengine/bevy/blob/v0.16.0/examples/README.md#android>

<https://github.com/bevyengine/bevy/tree/v0.16.0/examples/mobile/android_example>

<https://crates.io/crates/cargo-ndk>


Development Device:

Samsung Galaxy Note 10 Plus, Android 12, API 31, USB, 2019.

<https://developer.android.com/studio/debug/dev-options>


Android Gradle Plugin:

- latest version: 8.9.1
- Gradle 8.11.1+
- SDK Build Tools 35.0.0
- NDK 27.0.12077973
- JDK 17

<https://developer.android.com/build/releases/gradle-plugin#compatibility>


```sh
#
# Android SDK / NDK
#


sudo apt update

sudo apt install -y \
--no-install-recommends \
openjdk-17-jdk-headless \
openjdk-17-jre-headless \
java-common

sudo update-java-alternatives --set java-1.17.0-openjdk-amd64


java -version

# openjdk version "17.0.15-ea" 2025-04-15
# OpenJDK Runtime Environment (build 17.0.15-ea+5-Ubuntu-1)
# OpenJDK 64-Bit Server VM (build 17.0.15-ea+5-Ubuntu-1, mixed mode, sharing)


export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"


# https://developer.android.com/tools
# https://developer.android.com/studio#command-line-tools-only
# https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
# SHA-256 7ec965280a073311c339e571cd5de778b9975026cfcbe79f2b1cdcb1e15317ee


curl --proto '=https' --tlsv1.2 -sSfLO https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip

echo '7ec965280a073311c339e571cd5de778b9975026cfcbe79f2b1cdcb1e15317ee commandlinetools-linux-13114758_latest.zip' \
> checksum

sha256sum -c checksum

# commandlinetools-linux-13114758_latest.zip: OK

ls -alh commandlinetools-linux-13114758_latest.zip

# -rw-rw-r-- 1 cavani cavani 158M Apr 30 14:03 commandlinetools-linux-13114758_latest.zip

unzip commandlinetools-linux-13114758_latest.zip

cmdline-tools/bin/sdkmanager --help

# ...


export ANDROID_HOME="$HOME/Android/Sdk"
mkdir -p $ANDROID_HOME

cmdline-tools/bin/sdkmanager \
--sdk_root=$ANDROID_HOME \
--install \
'build-tools;35.0.0' \
'cmake;3.22.1' \
'cmdline-tools;latest' \
'ndk;27.0.12077973' \
platform-tools \
'platforms;android-35' \
emulator \
'system-images;android-35;default;x86_64'


export NDK_HOME="$ANDROID_HOME/ndk/27.0.12077973"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
# fish_add_path --path $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/cmdline-tools/latest/bin


# Onwards use cmdline-tools installed in Android Sdk Home
rm -rf cmdline-tools commandlinetools-linux-13114758_latest.zip checksum


# https://developer.android.com/studio/run/managing-avds


avdmanager --help

# ...


avdmanager create avd \
--name Pixel_9_Pro_API_35 \
--device pixel_9_pro \
--package 'system-images;android-35;default;x86_64'

avdmanager list avd

# Available Android Virtual Devices:
#     Name: Pixel_9_Pro_API_35
#   Device: pixel_9_pro (Google)
#     Path: /home/cavani/.config/.android/avd/Pixel_9_Pro_API_35.avd
#   Target: Default Android System Image
#           Based on: Android 15.0 ("VanillaIceCream") Tag/ABI: default/x86_64
#   Sdcard: 512 MB


export ANDROID_AVD_HOME="$HOME/.config/.android/avd"


emulator -list-avds

# Pixel_9_Pro_API_35


# WARNING
# - `-gpu host` dows not work at the moment (app closes after opening window)
# - `-gpu swiftshader_indirect` renders 3D scene but input does not work (camera movement, button)
 
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

emulator -avd Pixel_9_Pro_API_35 -gpu host -netdelay none -netspeed full

# [open emulator window running Android UI]


# **Other terminal**

echo '# Android env
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export NDK_HOME="$ANDROID_HOME/ndk/27.0.12077973"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
# fish_add_path --path $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/cmdline-tools/latest/bin' \
> android-env.sh

source android-env.sh


# https://developer.android.com/tools/adb


adb --help

# Android Debug Bridge version 1.0.41
# Version 35.0.2-12147458
# Installed as /home/cavani/Android/Sdk/platform-tools/adb
# Running on Linux 6.14.0-15-generic (x86_64)
# ...


adb devices

# List of devices attached
# RQ8MA0WKXCL     device
# emulator-5554   device


sdkmanager --list_installed

# Installed packages:
#   Path                                    | Version       | Description                             | Location
#   -------                                 | -------       | -------                                 | -------
#   build-tools;35.0.0                      | 35.0.0        | Android SDK Build-Tools 35              | build-tools/35.0.0
#   cmake;3.22.1                            | 3.22.1        | CMake 3.22.1                            | cmake/3.22.1
#   cmdline-tools;latest                    | 19.0          | Android SDK Command-line Tools (latest) | cmdline-tools/latest
#   emulator                                | 35.4.9        | Android Emulator                        | emulator
#   ndk;27.0.12077973                       | 27.0.12077973 | NDK (Side by side) 27.0.12077973        | ndk/27.0.12077973
#   platform-tools                          | 35.0.2        | Android SDK Platform-Tools              | platform-tools
#   platforms;android-35                    | 2             | Android SDK Platform 35                 | platforms/android-35
#   system-images;android-35;default;x86_64 | 2             | Intel x86_64 Atom System Image          | system-images/android-35/default/x86_64


#
# Bevy App - Rust Dynamic Library
#


echo '//! A 3d Scene with a button and playing sound.

use bevy::{
    color::palettes::basic::*,
    input::{gestures::RotationGesture, touch::TouchPhase},
    log::{Level, LogPlugin},
    prelude::*,
    window::{AppLifecycle, WindowMode},
    winit::WinitSettings,
};

// the `bevy_main` proc_macro generates the required boilerplate for Android
#[bevy_main]
/// The entry point for the application. Is `pub` so that it can be used from
/// `main.rs`.
pub fn main() {
    let mut app = App::new();
    app.add_plugins(
        DefaultPlugins
            .set(LogPlugin {
                // This will show some log events from Bevy to the native logger.
                level: Level::DEBUG,
                filter: "wgpu=error,bevy_render=info,bevy_ecs=trace".to_string(),
                ..Default::default()
            })
            .set(WindowPlugin {
                primary_window: Some(Window {
                    resizable: false,
                    mode: WindowMode::BorderlessFullscreen(MonitorSelection::Primary),
                    // on iOS, gestures must be enabled.
                    // This doesn'"'"'t work on Android
                    recognize_rotation_gesture: true,
                    // Only has an effect on iOS
                    prefers_home_indicator_hidden: true,
                    // Only has an effect on iOS
                    prefers_status_bar_hidden: true,
                    ..default()
                }),
                ..default()
            }),
    )
    // Make the winit loop wait more aggressively when no user input is received
    // This can help reduce cpu usage on mobile devices
    .insert_resource(WinitSettings::mobile())
    .add_systems(Startup, (setup_scene, setup_music))
    .add_systems(
        Update,
        (
            touch_camera,
            button_handler,
            // Only run the lifetime handler when an [`AudioSink`] component exists in the world.
            // This ensures we don'"'"'t try to manage audio that hasn'"'"'t been initialized yet.
            handle_lifetime.run_if(any_with_component::<AudioSink>),
        ),
    )
    .run();
}

fn touch_camera(
    window: Query<&Window>,
    mut touches: EventReader<TouchInput>,
    mut camera_transform: Single<&mut Transform, With<Camera3d>>,
    mut last_position: Local<Option<Vec2>>,
    mut rotations: EventReader<RotationGesture>,
) {
    let Ok(window) = window.single() else {
        return;
    };

    for touch in touches.read() {
        if touch.phase == TouchPhase::Started {
            *last_position = None;
        }
        if let Some(last_position) = *last_position {
            **camera_transform = Transform::from_xyz(
                camera_transform.translation.x
                    + (touch.position.x - last_position.x) / window.width() * 5.0,
                camera_transform.translation.y,
                camera_transform.translation.z
                    + (touch.position.y - last_position.y) / window.height() * 5.0,
            )
            .looking_at(Vec3::ZERO, Vec3::Y);
        }
        *last_position = Some(touch.position);
    }
    // Rotation gestures only work on iOS
    for rotation in rotations.read() {
        let forward = camera_transform.forward();
        camera_transform.rotate_axis(forward, rotation.0 / 10.0);
    }
}

/// set up a simple 3D scene
fn setup_scene(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
) {
    // plane
    commands.spawn((
        Mesh3d(meshes.add(Plane3d::default().mesh().size(5.0, 5.0))),
        MeshMaterial3d(materials.add(Color::srgb(0.1, 0.2, 0.1))),
    ));
    // cube
    commands.spawn((
        Mesh3d(meshes.add(Cuboid::default())),
        MeshMaterial3d(materials.add(Color::srgb(0.5, 0.4, 0.3))),
        Transform::from_xyz(0.0, 0.5, 0.0),
    ));
    // sphere
    commands.spawn((
        Mesh3d(meshes.add(Sphere::new(0.5).mesh().ico(4).unwrap())),
        MeshMaterial3d(materials.add(Color::srgb(0.1, 0.4, 0.8))),
        Transform::from_xyz(1.5, 1.5, 1.5),
    ));
    // light
    commands.spawn((
        PointLight {
            intensity: 1_000_000.0,
            // Shadows makes some Android devices segfault, this is under investigation
            // https://github.com/bevyengine/bevy/issues/8214
            #[cfg(not(target_os = "android"))]
            shadows_enabled: true,
            ..default()
        },
        Transform::from_xyz(4.0, 8.0, 4.0),
    ));
    // camera
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(-2.0, 2.5, 5.0).looking_at(Vec3::ZERO, Vec3::Y),
        // MSAA makes some Android devices panic, this is under investigation
        // https://github.com/bevyengine/bevy/issues/8229
        #[cfg(target_os = "android")]
        Msaa::Off,
    ));

    // Test ui
    commands
        .spawn((
            Button,
            Node {
                justify_content: JustifyContent::Center,
                align_items: AlignItems::Center,
                position_type: PositionType::Absolute,
                left: Val::Px(50.0),
                right: Val::Px(50.0),
                bottom: Val::Px(50.0),
                ..default()
            },
        ))
        .with_child((
            Text::new("Test Button"),
            TextFont {
                font_size: 30.0,
                ..default()
            },
            TextColor::BLACK,
            TextLayout::new_with_justify(JustifyText::Center),
        ));
}

fn button_handler(
    mut interaction_query: Query<
        (&Interaction, &mut BackgroundColor),
        (Changed<Interaction>, With<Button>),
    >,
) {
    for (interaction, mut color) in &mut interaction_query {
        match *interaction {
            Interaction::Pressed => {
                *color = BLUE.into();
            }
            Interaction::Hovered => {
                *color = GRAY.into();
            }
            Interaction::None => {
                *color = WHITE.into();
            }
        }
    }
}

fn setup_music(asset_server: Res<AssetServer>, mut commands: Commands) {
    commands.spawn((
        AudioPlayer::new(asset_server.load("sounds/Windless Slopes.ogg")),
        PlaybackSettings::LOOP,
    ));
}

// Pause audio when app goes into background and resume when it returns.
// This is handled by the OS on iOS, but not on Android.
fn handle_lifetime(
    mut lifecycle_events: EventReader<AppLifecycle>,
    music_controller: Single<&AudioSink>,
) {
    for event in lifecycle_events.read() {
        match event {
            AppLifecycle::Idle | AppLifecycle::WillSuspend | AppLifecycle::WillResume => {}
            AppLifecycle::Suspended => music_controller.pause(),
            AppLifecycle::Running => music_controller.play(),
        }
    }
}' \
> src/lib.rs


mkdir -p assets/sounds/

curl --proto "=https" --tlsv1.2 -sSfL -o assets/sounds/Windless\ Slopes.ogg \
https://raw.githubusercontent.com/bevyengine/bevy/v0.16.0/assets/sounds/Windless%20Slopes.ogg


echo '# Optimize for size in the mobile-release profile to reduce apk.
[profile.mobile-release]
# Default to release-lto profile values.
inherits = "release-lto"
# Optimize with size in mind.
# Slightly slows compile times, great improvements to file size and runtime performance.
opt-level = "z"

[lib]
name = "smartrobot_bevy"
crate-type = ["lib", "cdylib"]
' \
>> Cargo.toml


rustup target add \
aarch64-linux-android \
x86_64-linux-android

cargo binstall -y cargo-ndk


cargo ndk --version

# cargo-ndk 3.5.4


# Debug

rm -rf android/app/src/main/jniLibs/

cargo ndk \
-t arm64-v8a \
-t x86_64 \
-o android/app/src/main/jniLibs \
--no-strip \
build \
--lib \
--profile dev \
--features log-max

file -b android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, with debug_info, not stripped
# ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, with debug_info, not stripped

# ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, stripped
# ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, stripped

ls -alh android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# -rwxrwxr-x 1 cavani cavani 1.2G May  3 01:26 android/app/src/main/jniLibs/arm64-v8a/libsmartrobot_bevy.so
# -rwxrwxr-x 1 cavani cavani 1.2G May  3 01:26 android/app/src/main/jniLibs/x86_64/libsmartrobot_bevy.so


# Release

rm -rf android/app/src/main/jniLibs/

cargo ndk \
-t arm64-v8a \
-t x86_64 \
-o android/app/src/main/jniLibs \
build \
--lib \
--profile mobile-release \
--features log-max

file -b android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, stripped
# ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, stripped

ls -alh android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# -rwxrwxr-x 1 cavani cavani 29M May  2 11:01 android/app/src/main/jniLibs/arm64-v8a/libsmartrobot_bevy.so
# -rwxrwxr-x 1 cavani cavani 36M May  2 11:01 android/app/src/main/jniLibs/x86_64/libsmartrobot_bevy.so



#
# Bevy App - Android Project (Gradle / Java)
#


curl --proto "=https" --tlsv1.2 -sSfLO https://services.gradle.org/distributions/gradle-8.14-bin.zip

mkdir -p $HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/

unzip -d $HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/ gradle-8.14-bin.zip

mv gradle-8.14-bin.zip $HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/

touch $HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/gradle-8.14-bin.zip.ok

touch $HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/gradle-8.14-bin.zip.lck


# mkdir -p android/

cd android/

$HOME/.gradle/wrapper/dists/gradle-8.14-bin/38aieal9i53h9rfe7vjup95b9/gradle-8.14/bin/gradle init \
--type basic \
--dsl groovy \
--project-name "Smart Robot" \
--no-incubating \
--no-daemon \
--overwrite

find . -type f

# ./gradle/wrapper/gradle-wrapper.jar
# ./gradle/wrapper/gradle-wrapper.properties
# ./gradle/libs.versions.toml
# ./gradlew.bat
# ./gradle.properties
# ./app/src/main/jniLibs/arm64-v8a/libsmartrobot_bevy.so
# ./app/src/main/jniLibs/x86_64/libsmartrobot_bevy.so
# ./settings.gradle
# ./build.gradle
# ./.gitattributes
# ./gradlew
# ./.gitignore


mkdir -p app/src/main/java/dev/smartrobot/bevy_app/

echo 'package dev.smartrobot.bevy_app;

import android.view.View;
import android.view.WindowInsets;
import android.view.WindowInsetsController;

import com.google.androidgamesdk.GameActivity;

public class MainActivity extends GameActivity {
    static {
        System.loadLibrary("smartrobot_bevy");
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);

        if (hasFocus) {
            hideSystemUi();
        }
    }

    private void hideSystemUi() {
        final WindowInsetsController insetsController = getWindow().getInsetsController();
        if (insetsController != null) {
            insetsController.hide(WindowInsets.Type.statusBars() | WindowInsets.Type.navigationBars());
            insetsController.setSystemBarsBehavior(WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);
        }
    }
}' \
> app/src/main/java/dev/smartrobot/bevy_app/MainActivity.java


mkdir -p app/src/main/cpp/

echo '// Intentionally blank -- this is a dummy code!
// This is part of a hack to convince gradle to insert libc++_shared.so' \
> app/src/main/cpp/dummy.cpp


mkdir -p app/src/main/res/mipmap-mdpi/

curl --proto "=https" --tlsv1.2 -sSfL -o app/src/main/res/mipmap-mdpi/ic_launcher.png \
https://raw.githubusercontent.com/bevyengine/bevy/v0.16.0/assets/android-res/mipmap-mdpi/ic_launcher.png


echo '<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <application
        android:icon="@mipmap/ic_launcher"
        android:label="Smart Robot"
        android:roundIcon="@mipmap/ic_launcher"
        android:theme="@style/Theme.AppCompat.NoActionBar"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:theme="@style/Theme.AppCompat.NoActionBar">
            <meta-data
                android:name="android.app.lib_name"
                android:value="smartrobot_bevy" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>' \
> app/src/main/AndroidManifest.xml


echo '# This is part of a hack to convince gradle to insert libc++_shared.so
cmake_minimum_required(VERSION 3.4.1)
project(cppshared_dummy)
set (SRC_DIR ./src/main/cpp)
add_library (dummy SHARED ${SRC_DIR}/dummy.cpp)' \
> app/CMakeLists.txt


echo 'plugins {
    alias(libs.plugins.android.application)
}

android {
    namespace = "dev.smartrobot.bevy_app"
    compileSdk = 35

    defaultConfig {
        applicationId = "dev.smartrobot.bevy_app"
        minSdk = 31
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
        // need this otherwise it won'"'"'t insert libc++_shared.so
        externalNativeBuild {
            cmake {
                arguments = ["-DANDROID_STL=c++_shared"]
            }
        }
        // set up targets
        ndk {
            abiFilters = ["arm64-v8a", "x86_64"]
        }
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    externalNativeBuild {
        cmake {
            path = "CMakeLists.txt"
        }
    }
    buildTypes {
        release {
            minifyEnabled = false
            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    buildFeatures {
        prefab = true
    }
    // The final part to insert libc++_shared.so only
    packagingOptions {
        exclude "lib/*/libdummy.so"
    }
    sourceSets {
        main {
            assets.srcDirs += files("../../assets")
        }
    }
}

tasks.withType(JavaCompile).configureEach {
    options.compilerArgs += ["-Xlint:deprecation"]
}

dependencies {
    implementation libs.appcompat
    implementation libs.material
    implementation libs.games.activity
    testImplementation libs.junit
    androidTestImplementation libs.ext.junit
    androidTestImplementation libs.espresso.core
}' \
> app/build.gradle


echo '// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    alias(libs.plugins.android.application) apply false
}' \
> build.gradle


echo '# Project-wide Gradle settings.
# IDE (e.g. Android Studio) users:
# Gradle settings configured through the IDE *will override*
# any settings specified in this file.
# For more details on how to configure your build environment visit
# http://www.gradle.org/docs/current/userguide/build_environment.html
# Specifies the JVM arguments used for the daemon process.
# The setting is particularly useful for tweaking memory settings.
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
# When configured, Gradle will run in incubating parallel mode.
# This option should only be used with decoupled projects. More details, visit
# http://www.gradle.org/docs/current/userguide/multi_project_builds.html#sec:decoupled_projects
# org.gradle.parallel=true
# AndroidX package structure to make it clearer which packages are bundled with the
# Android operating system, and which are packaged with your app"s APK
# https://developer.android.com/topic/libraries/support-library/androidx-rn
android.useAndroidX=true
# Enables namespacing of each library'"'"'s R class so that its R class includes only the
# resources declared in the library itself and none from the library'"'"'s dependencies,
# thereby reducing the size of the R class for that library
android.nonTransitiveRClass=true
android.nonFinalResIds=false' \
> gradle.properties


echo 'pluginManagement {
    repositories {
        google {
            content {
                includeGroupByRegex("com\\\\.android.*")
                includeGroupByRegex("com\\\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "Smart Robot"
include ":app"' \
> settings.gradle


echo '[versions]
agp = "8.9.1"
junit = "4.13.2"
junitVersion = "1.1.5"
espressoCore = "3.5.1"
appcompat = "1.6.1"
material = "1.10.0"
gamesActivity = "2.0.2"

[libraries]
junit = { group = "junit", name = "junit", version.ref = "junit" }
ext-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
appcompat = { group = "androidx.appcompat", name = "appcompat", version.ref = "appcompat" }
material = { group = "com.google.android.material", name = "material", version.ref = "material" }
games-activity = { group = "androidx.games", name = "games-activity", version.ref = "gamesActivity" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }' \
> gradle/libs.versions.toml


find . -type f

# ./gradle/wrapper/gradle-wrapper.jar
# ./gradle/wrapper/gradle-wrapper.properties
# ./gradle/libs.versions.toml
# ./gradlew.bat
# ./gradle.properties
# ./app/src/main/cpp/dummy.cpp
# ./app/src/main/jniLibs/arm64-v8a/libsmartrobot_bevy.so
# ./app/src/main/jniLibs/x86_64/libsmartrobot_bevy.so
# ./app/src/main/java/dev/smartrobot/bevy_app/MainActivity.java
# ./app/src/main/AndroidManifest.xml
# ./app/src/main/res/mipmap-mdpi/ic_launcher.png
# ./app/build.gradle
# ./app/CMakeLists.txt
# ./settings.gradle
# ./build.gradle
# ./.gitattributes
# ./gradlew
# ./.gitignore


./gradlew --warning-mode all clean build


ls -alh ./app/build/outputs/apk/debug/app-debug.apk

# -rw-rw-r-- 1 cavani cavani 80M May  3 09:52 ./app/build/outputs/apk/debug/app-debug.apk

unzip -l ./app/build/outputs/apk/debug/app-debug.apk | grep lib

#   1292896  1981-01-01 01:01   lib/arm64-v8a/libc++_shared.so
#  30133272  1981-01-01 01:01   lib/arm64-v8a/libsmartrobot_bevy.so
#   1252080  1981-01-01 01:01   lib/x86_64/libc++_shared.so
#  37442384  1981-01-01 01:01   lib/x86_64/libsmartrobot_bevy.so


ls -alh ./app/build/outputs/apk/release/app-release-unsigned.apk

# -rw-rw-r-- 1 cavani cavani 78M May  3 09:52 ./app/build/outputs/apk/release/app-release-unsigned.apk

unzip -l ./app/build/outputs/apk/release/app-release-unsigned.apk | grep lib

#   1292896  1981-01-01 01:01   lib/arm64-v8a/libc++_shared.so
#  30133272  1981-01-01 01:01   lib/arm64-v8a/libsmartrobot_bevy.so
#   1252080  1981-01-01 01:01   lib/x86_64/libc++_shared.so
#  37442384  1981-01-01 01:01   lib/x86_64/libsmartrobot_bevy.so


adb -e install ./app/build/outputs/apk/debug/app-debug.apk

adb -e logcat | grep smartrobot

# ...
# 05-03 09:56:26.700  2311  2311 F DEBUG   : Cmdline: dev.smartrobot.bevy_app
# 05-03 09:56:26.700  2311  2311 F DEBUG   : pid: 2265, tid: 2288, name: Async Compute T  >>> dev.smartrobot.bevy_app <<<
# 05-03 09:56:26.700  2311  2311 F DEBUG   :       #01 pc 00000000020e22e9  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
# ...

adb -e logcat | grep RustStdoutStderr

# 05-03 09:56:26.268  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 0 name position
# 05-03 09:56:26.269  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 1 name color
# 05-03 09:56:26.272  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 0 name position
# 05-03 09:56:26.272  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 1 name color
# 05-03 09:56:26.457  2265  2286 I RustStdoutStderr:
# 05-03 09:56:26.457  2265  2286 I RustStdoutStderr: thread 'Async Compute Task Pool (0)' panicked at /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga-24.0.0/src/span.rs:74:29:
# 05-03 09:56:26.457  2265  2286 I RustStdoutStderr: byte index 96489672 is out of bounds of ``
# 05-03 09:56:26.457  2265  2286 I RustStdoutStderr: note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace

adb -e logcat | grep -e smartrobot -e 2265

# -> [Output adb -e logcat]


adb -d install ./app/build/outputs/apk/debug/app-debug.apk

adb -d logcat | grep AdapterInfo

# 05-03 10:12:19.864 29974 30018 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/srcAdapterInfo { name: "Mali-G76", vendor: 5045, device: 1913716736, device_type: IntegratedGpu, driver: "Mali-G76", driver_info: "v1.r32p1-01bet2-mbs2v39_0.131801e953429f661ecce1d5e1d2b3ef", backend: Vulkan }

adb -d logcat | grep RustStdoutStderr

# (empty)

adb -d logcat | grep -e smartrobot -e 29974

# -> [Output adb -d logcat]
```

<details>
<summary>Output adb -e logcat</summary>

```text
adb -e logcat | grep -e smartrobot -e 2265

05-03 09:55:28.692   568   624 V BackupManagerService: [UserID:0] restoreAtInstall pkg=dev.smartrobot.bevy_app token=1 restoreSet=0
05-03 09:55:28.714  1147  1188 D SessionCommitReceiver: Removing PromiseIcon for package: dev.smartrobot.bevy_app, install reason: 0, alreadyAddedPromiseIcon: false
05-03 09:55:28.720   568   891 I SdkSandboxManager: No SDKs used. Skipping SDK data reconcilation for CallingInfo{mUid=10148, mPackageName='dev.smartrobot.bevy_app, mAppProcessToken='null'}
05-03 09:55:28.730  1147  1188 D PackageUpdatedTask: Package updated: mOp=ADD packages=[dev.smartrobot.bevy_app]
05-03 09:55:28.744   568   883 D ShortcutService: adding package: dev.smartrobot.bevy_app userId0
05-03 09:55:28.744   568   883 D ShortcutService: handlePackageAdded: dev.smartrobot.bevy_app user=0
05-03 09:55:28.744   568   883 D ShortcutService: rescanPackageIfNeeded 0@dev.smartrobot.bevy_app, forceRescan=true , isNewApp=true
05-03 09:55:28.744   568   883 D ShortcutService: Package dev.smartrobot.bevy_app has 0 manifest shortcut(s), and 0 share target(s)
05-03 09:55:28.745   568   883 D ShortcutService: changing package: dev.smartrobot.bevy_app userId0
05-03 09:55:28.745   568   883 D ShortcutService: handlePackageChanged: dev.smartrobot.bevy_app user=0
05-03 09:55:28.745   568   883 D ShortcutService: rescanPackageIfNeeded 0@dev.smartrobot.bevy_app, forceRescan=true , isNewApp=true
05-03 09:55:28.745   568   883 D ShortcutService: Package dev.smartrobot.bevy_app has 0 manifest shortcut(s), and 0 share target(s)
05-03 09:55:28.747  1102  1102 D CarrierSvcBindHelper: onPackageAdded: dev.smartrobot.bevy_app
05-03 09:55:28.773  1147  1188 D PackageUpdatedTask: Package updated: mOp=UPDATE packages=[dev.smartrobot.bevy_app]
05-03 09:55:28.782  1102  1284 D ImsResolver: maybeAddedImsService, packageName: dev.smartrobot.bevy_app
05-03 09:55:28.789  1102  1102 D CarrierSvcBindHelper: onPackageModified: dev.smartrobot.bevy_app
05-03 09:55:28.798   924   924 I SafetyLabelChangedBroadcastReceiver: received broadcast packageName: dev.smartrobot.bevy_app, current user: UserHandle{0}, packageChangeEvent: NEW_INSTALL, intent user: UserHandle{0}
05-03 09:55:28.802  1102  1284 D ImsResolver: maybeAddedImsService, packageName: dev.smartrobot.bevy_app
05-03 09:56:25.218   568  1016 V SplashScreenExceptionList: SplashScreen checking exception for package dev.smartrobot.bevy_app (target sdk:35) -> false
05-03 09:56:25.220   568  1016 I ActivityTaskManager: START u0 {act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity bnds=[0,981][256,1341]} with LAUNCH_MULTIPLE from uid 10120 (BAL_ALLOW_VISIBLE_WINDOW) result code=0
05-03 09:56:25.222   917   957 V WindowManagerShell: Transition requested (#5): android.os.BinderProxy@a2c368f TransitionRequestInfo { type = OPEN, triggerTask = TaskInfo{userId=0 taskId=8 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=983835 supportsMultiWindow=true resizeMode=1 isResizeable=true minWidth=-1 minHeight=-1 defaultMinSize=220 token=WCT{android.window.IWindowContainerToken$Stub$Proxy@f0cfd1c} topActivityType=1 pictureInPictureParams=null shouldDockBigOverlays=false launchIntoPipHostTaskId=-1 lastParentTaskIdBeforePip=-1 displayCutoutSafeInsets=null topActivityInfo=ActivityInfo{d4e7d25 dev.smartrobot.bevy_app.MainActivity} launchCookies=[android.os.BinderProxy@42abefa] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=false isVisible=false isVisibleRequested=false isSleeping=false locusId=null displayAreaFeatureId=1 isTopActivityTransparent=false appCompatTaskInfo=AppCompatTaskInfo { topActivityInSizeCompat=false topActivityEligibleForLetterboxEducation= falseisLetterboxEducationEnabled= false isLetterboxDoubleTapEnabled= false topActivityEligibleForUserAspectRatioButton= false topActivityBoundsLetterboxed= false isFromLetterboxDoubleTap= false topActivityLetterboxVerticalPosition= -1 topActivityLetterboxHorizontalPosition= -1 topActivityLetterboxWidth=1280 topActivityLetterboxHeight=2856 isUserFullscreenOverrideEnabled=false isSystemFullscreenOverrideEnabled=false cameraCompatTaskInfo=CameraCompatTaskInfo { cameraCompatControlState=hidden freeformCameraCompatMode=inactive}}}, pipTask = null, remoteTransition = RemoteTransition { remoteTransition = android.window.IRemoteTransition$Stub$Proxy@bbfacab, appThread = android.app.IApplicationThread$Stub$Proxy@e7acf08, debugName = QuickstepLaunch }, displayChange = null, flags = 0, debugId = 5 }
05-03 09:56:25.233  1147  1147 I TopTaskTracker: onTaskMovedToFront: (moved taskInfo to front) taskId=8, baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity }
05-03 09:56:25.234   568   864 I AppWidgetServiceImpl: Updating package stopped masked state for uid 10148 package dev.smartrobot.bevy_app isStopped false
05-03 09:56:25.250   372   372 D Zygote  : Forked child process 2265
05-03 09:56:25.258   568   602 I ActivityManager: Start proc 2265:dev.smartrobot.bevy_app/u0a148 for next-top-activity {dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}
05-03 09:56:25.260  2265  2265 I trobot.bevy_app: Late-enabling -Xcheck:jni
05-03 09:56:25.281  2265  2265 I trobot.bevy_app: Using CollectorTypeCMC GC.
05-03 09:56:25.282  2265  2265 W trobot.bevy_app: Unexpected CPU variant for x86: x86_64.
05-03 09:56:25.282  2265  2265 W trobot.bevy_app: Known variants: atom, sandybridge, silvermont, goldmont, goldmont-plus, goldmont-without-sha-xsaves, tremont, kabylake, default
05-03 09:56:25.286   568  1010 D CoreBackPreview: Window{720942 u0 Splash Screen dev.smartrobot.bevy_app}: Setting back callback OnBackInvokedCallbackInfo{mCallback=android.window.IOnBackInvokedCallback$Stub$Proxy@c2403cb, mPriority=0, mIsAnimationCallback=false}
05-03 09:56:25.304   450   458 I adbd    : jdwp connection from 2265
05-03 09:56:25.310  2265  2265 D nativeloader: Load libframework-connectivity-tiramisu-jni.so using APEX ns com_android_tethering for caller /apex/com.android.tethering/javalib/framework-connectivity-t.jar: ok
05-03 09:56:25.324  2265  2265 W ziparchive: Unable to open '/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.dm': No such file or directory
05-03 09:56:25.324  2265  2265 W ziparchive: Unable to open '/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.dm': No such file or directory
05-03 09:56:25.380  2265  2265 D nativeloader: Configuring clns-7 for other apk /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk. target_sdk_version=35, uses_libraries=, library_path=/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/lib/x86_64:/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk!/lib/x86_64, permitted_path=/data:/mnt/expand:/data/user/0/dev.smartrobot.bevy_app
05-03 09:56:25.383  2265  2265 D CompatChangeReporter: Compat change id reported: 202956589; UID 10148; state: ENABLED
05-03 09:56:25.389  2265  2265 V GraphicsEnvironment: Currently set values for:
05-03 09:56:25.390  2265  2265 V GraphicsEnvironment:   angle_gl_driver_selection_pkgs=[]
05-03 09:56:25.390  2265  2265 V GraphicsEnvironment:   angle_gl_driver_selection_values=[]
05-03 09:56:25.390  2265  2265 V GraphicsEnvironment: Global.Settings values are invalid: number of packages: 0, number of values: 0
05-03 09:56:25.390  2265  2265 V GraphicsEnvironment: Neither updatable production driver nor prerelease driver is supported.
05-03 09:56:25.404  2265  2265 D CompatChangeReporter: Compat change id reported: 279646685; UID 10148; state: ENABLED
05-03 09:56:25.409   568  1010 I AppsFilter: interaction: PackageSetting{aa346f2 dev.smartrobot.bevy_app/10148} -> PackageSetting{84f2143 com.android.launcher3/10120} BLOCKED
05-03 09:56:25.520   568   589 V WindowManager: Sent Transition (#5) createdAt=05-03 09:56:25.213 via request=TransitionRequestInfo { type = OPEN, triggerTask = TaskInfo{userId=0 taskId=8 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=983835 supportsMultiWindow=true resizeMode=1 isResizeable=true minWidth=-1 minHeight=-1 defaultMinSize=220 token=WCT{RemoteToken{3e0c24a Task{ddf6265 #8 type=standard A=10148:dev.smartrobot.bevy_app}}} topActivityType=1 pictureInPictureParams=null shouldDockBigOverlays=false launchIntoPipHostTaskId=-1 lastParentTaskIdBeforePip=-1 displayCutoutSafeInsets=null topActivityInfo=ActivityInfo{12175bb dev.smartrobot.bevy_app.MainActivity} launchCookies=[android.os.BinderProxy@6c04ad8] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=false isVisible=false isVisibleRequested=false isSleeping=false locusId=null displayAreaFeatureId=1 isTopActivityTransparent=false appCompatTaskInfo=AppCompatTaskInfo { topActivityInSizeCompat=false topActivityEligibleForLetterboxEducation= falseisLetterboxEducationEnabled= false isLetterboxDoubleTapEnabled= false topActivityEligibleForUserAspectRatioButton= false topActivityBoundsLetterboxed= false isFromLetterboxDoubleTap= false topActivityLetterboxVerticalPosition= -1 topActivityLetterboxHorizontalPosition= -1 topActivityLetterboxWidth=1280 topActivityLetterboxHeight=2856 isUserFullscreenOverrideEnabled=false isSystemFullscreenOverrideEnabled=false cameraCompatTaskInfo=CameraCompatTaskInfo { cameraCompatControlState=hidden freeformCameraCompatMode=inactive}}}, pipTask = null, remoteTransition = RemoteTransition { remoteTransition = android.window.IRemoteTransition$Stub$Proxy@1bdde31, appThread = android.app.IApplicationThread$Stub$Proxy@270b916, debugName = QuickstepLaunch }, displayChange = null, flags = 0, debugId = 5 }
05-03 09:56:25.520   568   589 V WindowManager:         {WCT{RemoteToken{3e0c24a Task{ddf6265 #8 type=standard A=10148:dev.smartrobot.bevy_app}}} m=OPEN f=NONE leash=Surface(name=Task=8)/@0x6035bec sb=Rect(0, 0 - 1280, 2856) eb=Rect(0, 0 - 1280, 2856) d=0 taskParent=-1},
05-03 09:56:25.529  2265  2265 D nativeloader: Load /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk!/lib/x86_64/libsmartrobot_bevy.so using ns clns-7 from class loader (caller=/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk!classes3.dex): ok
05-03 09:56:25.540  2265  2265 D AppCompatDelegate: Checking for metadata for AppLocalesMetadataHolderService : Service not found
05-03 09:56:25.554  2265  2265 D CompatChangeReporter: Compat change id reported: 309578419; UID 10148; state: ENABLED
05-03 09:56:25.560  2265  2265 W trobot.bevy_app: Accessing hidden method Landroid/view/View;->computeFitSystemWindows(Landroid/graphics/Rect;Landroid/graphics/Rect;)Z (unsupported, reflection, allowed)
05-03 09:56:25.560  2265  2265 W trobot.bevy_app: Accessing hidden method Landroid/view/ViewGroup;->makeOptionalFitsSystemWindows()V (unsupported, reflection, allowed)
05-03 09:56:25.561  2265  2265 I GameActivity: Looking for library libsmartrobot_bevy.so
05-03 09:56:25.561  2265  2265 I GameActivity: Found library libsmartrobot_bevy.so. Loading...
05-03 09:56:25.563  2265  2265 D CompatChangeReporter: Compat change id reported: 312399441; UID 10148; state: ENABLED
05-03 09:56:25.567  2265  2265 D GameActivity: GameActivity_register
05-03 09:56:25.567  2265  2265 V GameActivity: Registering com/google/androidgamesdk/GameActivity's 22 native methods...
05-03 09:56:25.567  2265  2265 V threaded_app: Creating: 0x76de59b671b0
05-03 09:56:25.567  2265  2265 V threaded_app: Callbacks set: 0x76de59b67200
05-03 09:56:25.567  2265  2265 V threaded_app: Launching android_app_entry in a thread
05-03 09:56:25.567  2265  2285 V threaded_app: android_app_entry called
05-03 09:56:25.567  2265  2285 V threaded_app: android_app = 0x76de09b79050
05-03 09:56:25.567  2265  2285 V threaded_app: config = 0x76de39c00a70
05-03 09:56:25.567  2265  2285 V threaded_app: activity = 0x76de59b671b0
05-03 09:56:25.567  2265  2285 V threaded_app: assetmanager = 0x76de59b63330
05-03 09:56:25.567  2265  2285 V threaded_app: Config: mcc=310 mnc=260 lang=en cnt=US orien=1 touch=3 dens=480 keys=2 nav=1 keysHid=1 navHid=0 sdk=35 size=2 long=2 modetype=1 modenight=1
05-03 09:56:25.582  2265  2285 E platform: Failed to open rendernode: No such file or directory
05-03 09:56:25.584  2265  2265 V GameActivity: onStart_native
05-03 09:56:25.584  2265  2265 V threaded_app: Start: 0x76de59b671b0
05-03 09:56:25.591  2265  2285 D vulkan  : searching for layers in '/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/lib/x86_64'
05-03 09:56:25.591  2265  2285 D vulkan  : searching for layers in '/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk!/lib/x86_64'
05-03 09:56:25.605  2265  2285 I EGL_emulation: Opening libGLESv1_CM_emulation.so
05-03 09:56:25.605  2265  2285 I EGL_emulation: Opening libGLESv2_emulation.so
05-03 09:56:25.697  2265  2285 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/srcAdapterInfo { name: "NVIDIA GeForce MX570 A", vendor: 4318, device: 9642, device_type: DiscreteGpu, driver: "NVIDIA", driver_info: "570.133.07", backend: Vulkan }
05-03 09:56:25.929  2265  2285 I OboeAudio: openStreamInternal() OUTPUT -------- OboeVersion1.8.1 --------
05-03 09:56:25.931  2265  2285 I AAudio  : AAudioStreamBuilder_openStream() called ----------------------------------------
05-03 09:56:25.931  2265  2285 I AudioStreamBuilder: rate   =  44100, channels  = 2, channelMask = 0x80000003, format   = 5, sharing = SH, dir = OUTPUT
05-03 09:56:25.931  2265  2285 I AudioStreamBuilder: device =      0, sessionId = -1, perfMode = 10, callback: ON with frames = 0
05-03 09:56:25.931  2265  2285 I AudioStreamBuilder: usage  =      1, contentType = 2, inputPreset = 6, allowedCapturePolicy = 0
05-03 09:56:25.931  2265  2285 I AudioStreamBuilder: privacy sensitive = false, opPackageName = (null), attributionTag = (null)
05-03 09:56:25.931  2265  2285 D AudioStreamBuilder: build() MMAP not used because AAUDIO_PERFORMANCE_MODE_LOW_LATENCY not requested.
05-03 09:56:25.931  2265  2285 D trobot.bevy_app: PlayerBase::PlayerBase()
05-03 09:56:25.932  2265  2285 D AudioStreamTrack: open(), request notificationFrames = 0, frameCount = 0
05-03 09:56:25.934  2265  2285 D AAudioStream: setState(s#1) from 0 to 2
05-03 09:56:25.935  2265  2285 I AAudio  : AAudioStreamBuilder_openStream() returns 0 = AAUDIO_OK for s#1 ----------------
05-03 09:56:25.935  2265  2285 D AAudio  : AAudioStream_requestStart(s#1) called --------------
05-03 09:56:25.935  2265  2285 D AAudioStream: setState(s#1) from 2 to 3
05-03 09:56:25.936  2265  2285 D AAudio  : AAudioStream_requestStart(s#1) returned 0 ---------
05-03 09:56:25.936  2265  2281 D AudioStreamLegacy: onAudioDeviceUpdate(deviceId = 2)
05-03 09:56:25.937  2265  2285 E event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_gilrs-0.16.0/src/Failed to start Gilrs. Gilrs does not support current platform.
05-03 09:56:25.960  2265  2285 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/srcGPU preprocessing is fully supported on this device.
05-03 09:56:25.982  2265  2298 D AAudioStream: setState(s#1) from 3 to 4
05-03 09:56:25.987  2265  2285 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Creating new window App (0v1)
05-03 09:56:25.987  2265  2285 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Display information:  Window physical resolution: 1280x720  Window logical resolution: 1280x720  Monitor name: Android Device  Scale factor: 3  Refresh rate (Hz): 0.000
05-03 09:56:25.987  2265  2285 E event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfCannot get the native window, it's null and will always be null before Event::Resumed and after Event::Suspended. Make sure you only call this function between those events.
05-03 09:56:26.013  2265  2285 V threaded_app: activityState=10
05-03 09:56:26.013  2265  2285 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: forward onStart notification to application
05-03 09:56:26.015  2265  2265 V threaded_app: Resume: 0x76de59b671b0
05-03 09:56:26.015  2265  2285 V threaded_app: activityState=11
05-03 09:56:26.015  2265  2285 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfApp Resumed - is running
05-03 09:56:26.018  2265  2265 W HWUI    : Unknown dataspace 0
05-03 09:56:26.026  2265  2265 V threaded_app: WindowInsetsChanged: 0x76de59b671b0
05-03 09:56:26.026   568  1010 D CoreBackPreview: Window{2b30add u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}: Setting back callback OnBackInvokedCallbackInfo{mCallback=android.window.IOnBackInvokedCallback$Stub$Proxy@dae7d23, mPriority=0, mIsAnimationCallback=false}
05-03 09:56:26.036  2265  2265 V threaded_app: ContentRectChanged: 0x76de59b671b0 -- (0 0) (1280 2856)
05-03 09:56:26.036  2265  2265 V GameActivity: onSurfaceCreated_native
05-03 09:56:26.036  2265  2265 V threaded_app: NativeWindowCreated: 0x76de59b671b0 -- 0x76dd19b81540
05-03 09:56:26.036  2265  2265 V threaded_app: android_app_set_window called
05-03 09:56:26.041  2265  2282 W HWUI    : Failed to choose config with EGL_SWAP_BEHAVIOR_PRESERVED, retrying without...
05-03 09:56:26.041  2265  2282 W HWUI    : Failed to initialize 101010-2 format, error = EGL_SUCCESS
05-03 09:56:26.130     0     0 I servicemanager: Caller(pid=2265,uid=10148,sid=u:r:untrusted_app:s0:c148,c256,c512,c768) Could not find android.hardware.graphics.allocator.IAllocator/default in the VINTF manifest. No alternative instances declared in VINTF.
05-03 09:56:26.099  2265  2282 I Gralloc4: mapper 4.x is not supported
05-03 09:56:26.158  2265  2271 I trobot.bevy_app: Compiler allocated 5174KB to compile void android.view.ViewRootImpl.performTraversals()
05-03 09:56:26.196  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::fullscreen_vertex_shader with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.197  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::fullscreen_vertex_shader with defs: {}
05-03 09:56:26.198  2265  2285 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: handle Android InsetsChanged notification
05-03 09:56:26.198  2265  2285 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: find a way to notify application of content rect change
05-03 09:56:26.199  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::fullscreen_vertex_shader with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.200  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.209  2265  2285 V threaded_app: APP_CMD_INIT_WINDOW
05-03 09:56:26.209  2265  2285 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Display information:  Window physical resolution: 3840x2160  Window logical resolution: 1280x720  Monitor name: Android Device  Scale factor: 3  Refresh rate (Hz): 0.000
05-03 09:56:26.209  2265  2265 V threaded_app: NativeWindowResized: 0x76de59b671b0 -- 0x76dd19b81540 ( 1280 x 2856 )
05-03 09:56:26.210  2265  2265 V threaded_app: NativeWindowRedrawNeeded: 0x76de59b671b0 -- 0x76dd19b81540
05-03 09:56:26.230  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.238  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_preprocess_types with defs: {}
05-03 09:56:26.240  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_preprocess_types with defs: {"INDEXED": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.241  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"INDEXED": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.245  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_types with defs: {}
05-03 09:56:26.245  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::view with defs: {}
05-03 09:56:26.246  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_view_types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.247  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::globals with defs: {}
05-03 09:56:26.247  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_view_bindings with defs: {}
05-03 09:56:26.249  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::maths with defs: {}
05-03 09:56:26.249  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_bindings with defs: {}
05-03 09:56:26.251  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::view_transformations with defs: {}
05-03 09:56:26.251  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::occlusion_culling with defs: {}
05-03 09:56:26.256  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_preprocess_types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.256  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.258  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::view with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.260  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_view_types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.261  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::globals with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.261  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_view_bindings with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.264  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::maths with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.268  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 0 name position
05-03 09:56:26.268  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "INDIRECT": Bool(true), "FRUSTUM_CULLING": Bool(true), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.269  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 1 name color
05-03 09:56:26.272  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 0 name position
05-03 09:56:26.272  2265  2286 I RustStdoutStderr: s_glBindAttribLocation: bind attrib 1 name color
05-03 09:56:26.276  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"EARLY_PHASE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "OCCLUSION_CULLING": Bool(true)}
05-03 09:56:26.280  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.283  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"LATE_PHASE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "OCCLUSION_CULLING": Bool(true), "INDEXED": Bool(true)}
05-03 09:56:26.284  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::types with defs: {}
05-03 09:56:26.285  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::bindings with defs: {}
05-03 09:56:26.285  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::bruneton_functions with defs: {}
05-03 09:56:26.287  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::functions with defs: {}
05-03 09:56:26.289  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.290  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::bindings with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.295  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::bruneton_functions with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.297  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::functions with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.303  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.317  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.324  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.331  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"MAX_DIRECTIONAL_LIGHTS": UInt(10), "WRITE_INDIRECT_PARAMETERS_METADATA": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.332   568   589 W ziparchive: Unable to open '/data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.dm': No such file or directory
05-03 09:56:26.334   568   589 I ActivityTaskManager: Displayed dev.smartrobot.bevy_app/.MainActivity for user 0: +1s129ms
05-03 09:56:26.337  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"LATE_PHASE": Bool(true), "OCCLUSION_CULLING": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.340  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"EARLY_PHASE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "INDEXED": Bool(true), "OCCLUSION_CULLING": Bool(true)}
05-03 09:56:26.349  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "MULTISAMPLE": Bool(true)}
05-03 09:56:26.360  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576)}
05-03 09:56:26.365  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::forward_io with defs: {}
05-03 09:56:26.365  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_bindings with defs: {}
05-03 09:56:26.365  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::morph with defs: {}
05-03 09:56:26.366  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_functions with defs: {}
05-03 09:56:26.367  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::skinning with defs: {}
05-03 09:56:26.368  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::forward_io with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.369  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_bindings with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.372  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_view_bindings with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.374  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::prepass_bindings with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.374  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::view_transformations with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.377  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_functions with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.379  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_UVS": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "BINDLESS": Bool(true), "DEBAND_DITHER": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS_A": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true)}
05-03 09:56:26.381  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_io with defs: {}
05-03 09:56:26.382  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::meshlet_visibility_buffer_resolve with defs: {}
05-03 09:56:26.382  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_types with defs: {}
05-03 09:56:26.386  2265  2265 V threaded_app: WindowFocusChanged: 0x76de59b671b0 -- 1
05-03 09:56:26.386  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::lighting with defs: {}
05-03 09:56:26.386  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::color_operations with defs: {}
05-03 09:56:26.386  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::utils with defs: {}
05-03 09:56:26.388  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::clustered_forward with defs: {}
05-03 09:56:26.391  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::shadow_sampling with defs: {}
05-03 09:56:26.392  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::shadows with defs: {}
05-03 09:56:26.392   568   680 I ImeTracker: dev.smartrobot.bevy_app:d0589723: onRequestHide at ORIGIN_SERVER reason HIDE_UNSPECIFIED_WINDOW fromUser false
05-03 09:56:26.392   568   680 I ImeTracker: dev.smartrobot.bevy_app:d0589723: onCancelled at PHASE_SERVER_SHOULD_HIDE
05-03 09:56:26.393  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::ambient with defs: {}
05-03 09:56:26.393  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::light_probe with defs: {}
05-03 09:56:26.394  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::irradiance_volume with defs: {}
05-03 09:56:26.396  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::environment_map with defs: {}
05-03 09:56:26.396  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_utils with defs: {}
05-03 09:56:26.396  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::tonemapping_lut_bindings with defs: {}
05-03 09:56:26.398  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::tonemapping with defs: {}
05-03 09:56:26.399  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::transmission with defs: {}
05-03 09:56:26.400  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::fog with defs: {}
05-03 09:56:26.404  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_functions with defs: {}
05-03 09:56:26.405  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::decal::forward with defs: {}
05-03 09:56:26.405  2265  2265 V threaded_app: WindowInsetsChanged: 0x76de59b671b0
05-03 09:56:26.406  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_bindings with defs: {}
05-03 09:56:26.406  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::bindless with defs: {}
05-03 09:56:26.406  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::parallax_mapping with defs: {}
05-03 09:56:26.406  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::ssao_utils with defs: {}
05-03 09:56:26.407  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::lightmap with defs: {}
05-03 09:56:26.409  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_fragment with defs: {}
05-03 09:56:26.409  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::decal::clustered with defs: {}
05-03 09:56:26.409  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_deferred_types with defs: {}
05-03 09:56:26.410  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::rgb9e5 with defs: {}
05-03 09:56:26.410  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_prepass_functions with defs: {}
05-03 09:56:26.411  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_deferred_functions with defs: {}
05-03 09:56:26.411  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::oit with defs: {}
05-03 09:56:26.414  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_types with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.420  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::lighting with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.424  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::clustered_forward with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.429  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::utils with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.429  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::shadow_sampling with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.434  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::color_operations with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.434  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::shadows with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.436  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::ambient with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.439  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping_lut_bindings with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.439  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.441  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_functions with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.445  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_bindings with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.446  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::bindless with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.446  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_fragment with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.450  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::decal::clustered with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.451  2265  2288 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(1048576), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_POSITIONS": Bool(true), "VERTEX_NORMALS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "DEBAND_DITHER": Bool(true), "VERTEX_UVS": Bool(true), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "MAX_CASCADES_PER_LIGHT": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "BINDLESS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 09:56:26.457  2265  2286 I RustStdoutStderr:
05-03 09:56:26.457  2265  2286 I RustStdoutStderr: thread 'Async Compute Task Pool (0)' panicked at /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga-24.0.0/src/span.rs:74:29:
05-03 09:56:26.457  2265  2286 I RustStdoutStderr: byte index 96489672 is out of bounds of ``
05-03 09:56:26.457  2265  2286 I RustStdoutStderr: note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
05-03 09:56:26.458  2265  2288 F libc    : Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 2288 (Async Compute T), pid 2265 (trobot.bevy_app)
05-03 09:56:26.483  2311  2311 E crash_dump64: failed to get the guest state header for thread 2265: Bad address
05-03 09:56:26.503  2311  2311 I crash_dump64: performing dump of process 2265 (target tid = 2288)
05-03 09:56:26.726     0     0 I logd    : logdr: UID=10148 GID=10148 PID=2311 n tail=500 logMask=8 pid=2265 start=0ns deadline=0ns
05-03 09:56:26.731     0     0 I logd    : logdr: UID=10148 GID=10148 PID=2311 n tail=500 logMask=1 pid=2265 start=0ns deadline=0ns
05-03 09:56:26.700  2311  2311 F DEBUG   : Cmdline: dev.smartrobot.bevy_app
05-03 09:56:26.700  2311  2311 F DEBUG   : pid: 2265, tid: 2288, name: Async Compute T  >>> dev.smartrobot.bevy_app <<<
05-03 09:56:26.700  2311  2311 F DEBUG   :       #01 pc 00000000020e22e9  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #02 pc 00000000020e22d1  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #03 pc 00000000020d2c9d  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #04 pc 00000000020d2ab4  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #05 pc 00000000020d2749  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #06 pc 00000000020d0ee8  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #07 pc 00000000020d23dc  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #08 pc 00000000020f632f  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #09 pc 00000000020fdbc1  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #10 pc 00000000020fd829  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #11 pc 0000000001be7658  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #12 pc 0000000001c53e7f  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #13 pc 0000000001aeafad  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #14 pc 0000000001af2ad7  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #15 pc 0000000001af39a2  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #16 pc 0000000001af416e  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #17 pc 0000000001a7c95f  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #18 pc 0000000001a7d378  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #19 pc 0000000001996f15  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #20 pc 00000000019ae23b  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #21 pc 000000000194f52f  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #22 pc 0000000002046d01  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #23 pc 00000000020454fe  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #24 pc 0000000002043b3c  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #25 pc 00000000020450b3  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #26 pc 0000000002045277  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #27 pc 0000000002044fca  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #28 pc 00000000020459d7  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.700  2311  2311 F DEBUG   :       #29 pc 00000000020d465a  /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk (offset 0x28a8000)
05-03 09:56:26.712   568  1010 D CoreBackPreview: Window{720942 u0 Splash Screen dev.smartrobot.bevy_app EXITING}: Setting back callback null
05-03 09:56:26.712   568   633 W InputManager-JNI: Input channel object '720942 Splash Screen dev.smartrobot.bevy_app (client)' was disposed without first being removed with the input manager!
05-03 09:56:26.716   568  2318 W ActivityTaskManager:   Force finishing activity dev.smartrobot.bevy_app/.MainActivity
05-03 09:56:26.725  2265  2265 V threaded_app: Pause: 0x76de59b671b0
05-03 09:56:26.733   372   372 I Zygote  : Process 2265 exited due to signal 6 (Aborted)
05-03 09:56:26.734   568  1611 I WindowManager: WIN DEATH: Window{2b30add u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}
05-03 09:56:26.734   568  1611 W InputManager-JNI: Input channel object '2b30add dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity (client)' was disposed without first being removed with the input manager!
05-03 09:56:26.734   568  1017 I ActivityManager: Process dev.smartrobot.bevy_app (pid 2265) has died: fg  TOP
05-03 09:56:26.735   568  1635 I ImeTracker: dev.smartrobot.bevy_app:557a8a65: onRequestHide at ORIGIN_SERVER reason HIDE_REMOVE_CLIENT fromUser false
05-03 09:56:26.735   568  1635 I ImeTracker: dev.smartrobot.bevy_app:557a8a65: onCancelled at PHASE_SERVER_SHOULD_HIDE
05-03 09:56:26.738   568   592 W ActivityManager: setHasOverlayUi called on unknown pid: 2265
05-03 09:56:26.757   568   603 I libprocessgroup: Removed cgroup /sys/fs/cgroup/uid_10148/pid_2265
05-03 09:56:26.776   568   593 W ActivityTaskManager: Unable to send transaction to client proc dev.smartrobot.bevy_app: no app thread
05-03 09:56:26.956   568   589 V WindowManager:         {WCT{RemoteToken{3e0c24a Task{ddf6265 #8 type=standard A=10148:dev.smartrobot.bevy_app}}} m=CLOSE f=NONE leash=Surface(name=Task=8)/@0x6035bec sb=Rect(0, 0 - 1280, 2856) eb=Rect(0, 0 - 1280, 2856) d=0 taskParent=-1},
05-03 09:56:26.972   568   593 W ActivityTaskManager: Unable to send transaction to client proc dev.smartrobot.bevy_app: no app thread
05-03 09:56:27.034   917   929 W ndroid.systemui: ApkAssets: Deleting an ApkAssets object '<empty> and /data/app/~~40IqnXhHfF0mxDXDz5Demg==/dev.smartrobot.bevy_app-h38K0y_FZ5MvC__NaTpPrw==/base.apk' with 1 weak references
05-03 09:56:27.263   568  1668 W WindowManager: Exception thrown during dispatchAppVisibility Window{2b30add u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity EXITING}
05-03 09:56:27.264   568  1668 W Process : Unable to open /proc/2265/status
```
</details>

<details>
<summary>Output adb -d logcat</summary>

```text
adb -d logcat | grep -e smartrobot -e 29974

05-03 10:12:19.470 26231 26496 I Pageboost: start alp : dev.smartrobot.bevy_app
05-03 10:12:19.471 26231 26500 I Pageboost: alp for : dev.smartrobot.bevy_app , 0
05-03 10:12:19.471  2652 29964 E pageboostd: alp start : app devsmartrobotbevy_app
05-03 10:12:19.476  2652 29964 E pageboostd: devsmartrobotbevy_app, amt 0 scnt 0 fcnt 0
05-03 10:12:19.476  2652 29964 E pageboostd: devsmartrobotbevy_app, amt 0 scnt 0 fcnt 0
05-03 10:12:19.476  2652 29964 E pageboostd: alp end : app devsmartrobotbevy_app data_amount 0
05-03 10:12:19.541 27039 27141 I AppIconSolution: return the original icon because tray option is set to None for dev.smartrobot.bevy_app, isNight = true
05-03 10:12:19.541 27039 27141 I LauncherActivityInfo: packageName: dev.smartrobot.bevy_app, useThemeIcon: true, height: 896, width: 896, density: 640
05-03 10:12:19.542 26231 27048 I ActivityTaskManager: START u0 {act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity bnds=[1128,370][1389,784]} from uid 10114
05-03 10:12:19.544 26231 27048 D ActivityTaskManager: TaskLaunchParamsModifier:task=null activity=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity display-from-option=0 display-id=0 display-windowing-mode=1 suggested-display-area=DefaultTaskDisplayArea@189868026
05-03 10:12:19.544 26231 27048 D [secipm]: mSecIpmManager Preload dev.smartrobot.bevy_app dex files
05-03 10:12:19.544 26231 27048 D ActivityTaskManager: TaskLaunchParamsModifier:task=null activity=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t-1} display-from-option=0 display-id=0 display-windowing-mode=1 suggested-display-area=DefaultTaskDisplayArea@189868026 inherit-from-source=fullscreen activity-options-fullscreen=Rect(0, 0 - 0, 0) non-freeform-display display-area=DefaultTaskDisplayArea@189868026 maximized-bounds
05-03 10:12:19.544 26231 27706 D PkgPredictorService-IpmAdcpController: create a new DexPreloadTask pkg:dev.smartrobot.bevy_app  path:/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==
05-03 10:12:19.545 26231 27048 D ActivityTaskManager: TaskLaunchParamsModifier:task=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=false mode=fullscreen translucent=true sz=0} activity=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t-1} display-from-option=0 display-id=0 display-windowing-mode=1 suggested-display-area=DefaultTaskDisplayArea@189868026 inherit-from-source=fullscreen activity-options-fullscreen=Rect(0, 0 - 0, 0) non-freeform-display display-area=DefaultTaskDisplayArea@189868026 maximized-bounds
05-03 10:12:19.547   642  3090 I SurfaceFlinger: id=12925 createSurf (0x0),-1 flag=80004, ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}#0
05-03 10:12:19.548 26526 26635 D StartingSurfaceDrawer: addSplashScreen dev.smartrobot.bevy_app theme=7f100220 task=12 suggestType=1
05-03 10:12:19.552 26231 26231 I Pageboost: package dev.smartrobot.bevy_app
05-03 10:12:19.552 26231 26500 I Pageboost: Record App IO : dev.smartrobot.bevy_app pid 0
05-03 10:12:19.555   642  3090 I SurfaceFlinger: id=12926 createSurf (0x0),-1 flag=80004, fcf25c5 Splash Screen dev.smartrobot.bevy_app#0
05-03 10:12:19.558 26231 27048 D MARsPolicyManager: onPackageResumedFG pkgName = dev.smartrobot.bevy_app, userId = 0
05-03 10:12:19.566 26004 26004 D Zygote  : Forked child process 29974
05-03 10:12:19.567 26231 26257 I ActivityManager: Start proc 29974:dev.smartrobot.bevy_app/u0a728 for pre-top-activity {dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}
05-03 10:12:19.567 26231 26257 D ActivityManager: [SecIpm] it's a ML_TYPE_EMPTYPROCESS protected process dev.smartrobot.bevy_app
05-03 10:12:19.571 26231 28023 V WindowManager: Relayout Window{fcf25c5 u0 Splash Screen dev.smartrobot.bevy_app}: viewVisibility=0 req=1440x3040 d0
05-03 10:12:19.571   642  3090 I SurfaceFlinger: id=12927 createSurf (1x1),-3 flag=40004, Splash Screen dev.smartrobot.bevy_app$_26526#0
05-03 10:12:19.572 26231 28023 D WindowManager: makeSurface duration=1 name=Splash Screen dev.smartrobot.bevy_app$_26526
05-03 10:12:19.573 26231 28023 D WindowManager: rotationForOrientation, orientationSource=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}
05-03 10:12:19.575 26231 27048 D WindowManager: rotationForOrientation, orientationSource=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}
05-03 10:12:19.577 29974 29974 I trobot.bevy_ap: Late-enabling -Xcheck:jni
05-03 10:12:19.580 26231 27048 D WindowManager: finishDrawingWindow: Window{fcf25c5 u0 Splash Screen dev.smartrobot.bevy_app} mDrawState=DRAW_PENDING
05-03 10:12:19.584 26231 26250 D WindowManager: createAnimationAdapter(): container=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:19.585 26231 26250 D WindowManager:         Add container=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:19.590 26231 26250 I WindowManager: container=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:19.590 26231 26250 I WindowManager:   taskInfo=TaskInfo{userId=0 taskId=12 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=990779295 supportsSplitScreenMultiWindow=true supportsMultiWindow=true resizeMode=1 isResizeable=true token=WCT{RemoteToken{b436a07 Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}}} topActivityType=1 pictureInPictureParams=PictureInPictureParams( aspectRatio=null sourceRectHint=null hasSetActions=false isAutoPipEnabled=false isSeamlessResizeEnabled=true) displayCutoutSafeInsets=Rect(0, 113 - 0, 0) topActivityInfo=ActivityInfo{e6c7734 dev.smartrobot.bevy_app.MainActivity} launchCookies=[android.os.BinderProxy@6b8c95d] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=false isVisible=true topActivityInSizeCompat=false locusId= null topLaunchHome=false launchSplitWindowingMode=0 isPairTask=false pairedTaskIds=[] pairWindowingMode=0 pairDockSide=0 isAnimatingByRecent=false originallySupportedSplitScreen=true isAnimatingFreeformToFullscreen=false topActivityInFixedAspectRatio=false isTopTransparentActivity=true}
05-03 10:12:19.592 26231 26249 D WindowManager:         container=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:19.600 25967 25972 I adbd    : jdwp connection from 29974
05-03 10:12:19.601 29974 29974 E USNET   : USNET: appName: dev.smartrobot.bevy_app
05-03 10:12:19.602 29974 29974 D ProcessState: Binder ioctl to enable oneway spam detection failed: Invalid argument
05-03 10:12:19.606 29974 29974 D ActivityThread: setConscryptValidator
05-03 10:12:19.607 29974 29974 D ActivityThread: setConscryptValidator - put
05-03 10:12:19.608   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd7fe70 | 0100 | RGBA_8888    |    0.0    0.0 1440.0 3040.0 |    0    0 1440 3040 | Splash Screen dev.smartrobot.bevy_app$_26526#0
05-03 10:12:19.611 26231 27048 I ActivityManager: DSS OFF for dev.smartrobot.bevy_app
05-03 10:12:19.613 26231 27048 I DexController: getTaskHasActivityIsWaitingToRun: r=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}, app=ProcessRecord{d35164b 29974:dev.smartrobot.bevy_app/u0a728}
05-03 10:12:19.613 26231 27048 D ActivityManager: attachApplicationLocked() app=ProcessRecord{d35164b 29974:dev.smartrobot.bevy_app/u0a728} app.isolatedEntryPoint=null instr2=null
05-03 10:12:19.614 26231 27048 D WindowManager: rotationForOrientation, orientationSource=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}
05-03 10:12:19.614 26231 27048 D SGM:PkgDataHelper: notifyAppCreate(), pkgName: dev.smartrobot.bevy_app, userId: 0, sendRet: true
05-03 10:12:19.614 26231 26371 D SGM:GameManager: onLooperPrepared(), msg: MSG_APP_CREATE, pkgName: dev.smartrobot.bevy_app, userId: 0
05-03 10:12:19.615 26231 27048 D SGM:GameManager:   sendRunningComponentFocus(), pkgName: dev.smartrobot.bevy_app, userId: 0
05-03 10:12:19.615 26231 26371 D SGM:GameManager: onLooperPrepared(), msg: MSG_TASK_FOCUSED, pkgName: dev.smartrobot.bevy_app, userId: 0
05-03 10:12:19.615 26231 26371 D SGM:GameManager:   handleTaskFocused(), pkgName: dev.smartrobot.bevy_app, userID:0
05-03 10:12:19.615 26231 26371 D SGM:GameManager:   handleResume(). pkgName: dev.smartrobot.bevy_app, userId: 0, isTunableApp: null
05-03 10:12:19.615 26231 26371 D SGM:GameManager: notifyFocusInOut(). of pkg: dev.smartrobot.bevy_app, type: 4, isMinimized: false, isTunableApp: false, userId: 0
05-03 10:12:19.616 26231 26370 V ActivityManager: Changed top to ProcessRecord{d35164b 29974:dev.smartrobot.bevy_app/u0a728}
05-03 10:12:19.618 26231 26247 D SSRM:LoadDetectMonitor: PID = 29974, UID = 10728
05-03 10:12:19.624 29974 29974 D ActivityThread: handleBindApplication()++ app=dev.smartrobot.bevy_app
05-03 10:12:19.626 29974 29974 D CompatibilityChangeReporter: Compat change id reported: 171979766; UID 10728; state: ENABLED
05-03 10:12:19.639 26231 26249 I GameSDK@LifeCycle: noteResumeComponent(): package name  : dev.smartrobot.bevy_app
05-03 10:12:19.639 26231 26249 D SGM:GameManager: noteResumeComponent(), received pkgName: dev.smartrobot.bevy_app, userId: 0
05-03 10:12:19.640 26231 26371 D SGM:GameManager: onLooperPrepared(), msg: MSG_APP_RESUME, pkgName: dev.smartrobot.bevy_app, userid: 0
05-03 10:12:19.640 26231 26371 D SGM:GameManager:   handleResume(). pkgName: dev.smartrobot.bevy_app, userId: 0, isTunableApp: null
05-03 10:12:19.640 26231 26371 D SGM:GameManager: notifyFocusInOut(). of pkg: dev.smartrobot.bevy_app, type: 4, isMinimized: false, isTunableApp: false, userId: 0
05-03 10:12:19.640 26231 26249 D SGM:GameManager: identifyGamePackage. dev.smartrobot.bevy_app, mCurrentUserId: 0, callerUserId: 0, callingMethodInfo: com.android.server.ssrm.fgapps.GameAppUtils.isGame(GameAppUtils.java:84)
05-03 10:12:19.640 26231 26249 D SGM:PkgDataHelper: getGamePkgData(). dev.smartrobot.bevy_app
05-03 10:12:19.640 26231 26249 D SGM:GameManager: identifyGamePackage. dev.smartrobot.bevy_app, mCurrentUserId: 0, callerUserId: 0, callingMethodInfo: com.android.server.ssrm.SortingMachine.isGame(SortingMachine.java:162)
05-03 10:12:19.640 26231 26249 D SGM:PkgDataHelper: getGamePkgData(). dev.smartrobot.bevy_app
05-03 10:12:19.641 26231 26249 D SGM:GameManager: identifyGamePackage. dev.smartrobot.bevy_app, mCurrentUserId: 0, callerUserId: 0, callingMethodInfo: com.samsung.android.game.SemGameManager.isGamePackage(SemGameManager.java:104)
05-03 10:12:19.641 26231 26249 D SGM:PkgDataHelper: getGamePkgData(). dev.smartrobot.bevy_app
05-03 10:12:19.641 26231 26249 D SGM:SemGameManager: isGamePackage(), pkgName=dev.smartrobot.bevy_app, ret=false
05-03 10:12:19.654 26231 26500 I Pageboost: 64 bit checked : true for 29974
05-03 10:12:19.654 26231 26500 I Pageboost: IoRecord pid : 29974, started correctly
05-03 10:12:19.683 29974 29974 V GraphicsEnvironment: ANGLE Developer option for 'dev.smartrobot.bevy_app' set to: 'default'
05-03 10:12:19.683 29974 29974 V GraphicsEnvironment: App is not on the allowlist for updatable production driver.
05-03 10:12:19.685 29974 29974 D LoadedApk: LoadedApk::makeApplication() appContext.mOpPackageName=dev.smartrobot.bevy_app appContext.mBasePackageName=dev.smartrobot.bevy_app
05-03 10:12:19.685 29974 29974 D NetworkSecurityConfig: No Network Security Config specified, using platform default
05-03 10:12:19.696 29974 29974 D NetworkSecurityConfig: No Network Security Config specified, using platform default
05-03 10:12:19.710 29974 29974 D ActivityThread: handleBindApplication() --
05-03 10:12:19.716 29974 30004 D OpenGLRenderer: RenderThread::requireGlContext()
05-03 10:12:19.721 29974 30004 I libEGL  : EGL_ANDROID_blob_cache_path advertised, but unable to get eglSetBlobCachePathANDROID
05-03 10:12:19.724 29974 30004 D OpenGLRenderer: RenderThread::setGrContext()
05-03 10:12:19.750 26231 26560 D MdnieScenarioControlService:  packageName : dev.smartrobot.bevy_app    className : dev.smartrobot.bevy_app.MainActivity
05-03 10:12:19.752 29974 29974 D AppCompatDelegate: Checking for metadata for AppLocalesMetadataHolderService : Service not found
05-03 10:12:19.772 29974 29974 I DecorView: [INFO] isPopOver=false, config=true
05-03 10:12:19.772 29974 29974 I DecorView: updateCaptionType >> DecorView@9d5c6ee[], isFloating=false, isApplication=true, hasWindowControllerCallback=true, hasWindowDecorCaption=false
05-03 10:12:19.772 29974 29974 D DecorView: setCaptionType = 0, this = DecorView@9d5c6ee[]
05-03 10:12:19.775 29974 29974 I DecorView: getCurrentDensityDpi: from real metrics. densityDpi=560 msg=resources_loaded
05-03 10:12:19.781 29974 29974 W trobot.bevy_ap: Accessing hidden method Landroid/view/View;->computeFitSystemWindows(Landroid/graphics/Rect;Landroid/graphics/Rect;)Z (unsupported, reflection, allowed)
05-03 10:12:19.782 29974 29974 W trobot.bevy_ap: Accessing hidden method Landroid/view/ViewGroup;->makeOptionalFitsSystemWindows()V (unsupported, reflection, allowed)
05-03 10:12:19.784 29974 29974 I GameActivity: Looking for library libsmartrobot_bevy.so
05-03 10:12:19.784 29974 29974 I GameActivity: Found library libsmartrobot_bevy.so. Loading...
05-03 10:12:19.790 29974 29974 D GameActivity: GameActivity_register
05-03 10:12:19.791 29974 29974 V GameActivity: Registering com/google/androidgamesdk/GameActivity's 22 native methods...
05-03 10:12:19.791 29974 29974 V threaded_app: Creating: 0x7446f4f1f0
05-03 10:12:19.791 29974 29974 V threaded_app: Callbacks set: 0x7446f4f240
05-03 10:12:19.791 29974 29974 V threaded_app: Launching android_app_entry in a thread
05-03 10:12:19.791 29974 30018 V threaded_app: android_app_entry called
05-03 10:12:19.791 29974 30018 V threaded_app: android_app = 0x7426f5a190
05-03 10:12:19.791 29974 30018 V threaded_app: config = 0x7396f7a970
05-03 10:12:19.791 29974 30018 V threaded_app: activity = 0x7446f4f1f0
05-03 10:12:19.791 29974 30018 V threaded_app: assetmanager = 0x7446f4c950
05-03 10:12:19.791 29974 30018 V threaded_app: Config: mcc=0 mnc=0 lang=en cnt=US orien=1 touch=3 dens=560 keys=1 nav=1 keysHid=3 navHid=0 sdk=31 size=2 long=2 modetype=1 modenight=2
05-03 10:12:19.796   528   528 E audit   : type=1400 audit(1746277939.789:19255): avc:  denied  { read } for  pid=29974 comm="android_main" name="cpu.cfs_quota_us" dev="cgroup" ino=9 scontext=u:r:untrusted_app:s0:c216,c258,c512,c768 tcontext=u:object_r:cgroup:s0 tclass=file permissive=0 SEPF_SM-N975F_12_0001 audit_filtered
05-03 10:12:19.796   528   528 E audit   : type=1300 audit(1746277939.789:19255): arch=c00000b7 syscall=56 success=no exit=-13 a0=ffffff9c a1=732e1798b8 a2=80000 a3=0 items=0 ppid=26004 pid=29974 auid=4294967295 uid=10728 gid=10728 euid=10728 suid=10728 fsuid=10728 egid=10728 sgid=10728 fsgid=10728 tty=(none) ses=4294967295 comm="android_main" exe="/system/bin/app_process64" subj=u:r:untrusted_app:s0:c216,c258,c512,c768 key=(null)
05-03 10:12:19.796   528   528 E audit   : type=1327 audit(1746277939.789:19255): proctitle="dev.smartrobot.bevy_app"
05-03 10:12:19.796   528   528 E audit   : type=1400 audit(1746277939.789:19256): avc:  denied  { read } for  pid=29974 comm="android_main" name="cpu.cfs_period_us" dev="cgroup" ino=10 scontext=u:r:untrusted_app:s0:c216,c258,c512,c768 tcontext=u:object_r:cgroup:s0 tclass=file permissive=0 SEPF_SM-N975F_12_0001 audit_filtered
05-03 10:12:19.796   528   528 E audit   : type=1300 audit(1746277939.789:19256): arch=c00000b7 syscall=56 success=no exit=-13 a0=ffffff9c a1=732e1798b8 a2=80000 a3=0 items=0 ppid=26004 pid=29974 auid=4294967295 uid=10728 gid=10728 euid=10728 suid=10728 fsuid=10728 egid=10728 sgid=10728 fsgid=10728 tty=(none) ses=4294967295 comm="android_main" exe="/system/bin/app_process64" subj=u:r:untrusted_app:s0:c216,c258,c512,c768 key=(null)
05-03 10:12:19.802 29974 30018 D vulkan  : searching for layers in '/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/lib/arm64'
05-03 10:12:19.802 29974 30018 D vulkan  : searching for layers in '/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/base.apk!/lib/arm64-v8a'
05-03 10:12:19.822 26231 26454 W SemWifiTransportLayerUtils: getApplicationCategory - IOException dev.smartrobot.bevy_app
05-03 10:12:19.822 26231 26454 W System.err: java.io.FileNotFoundException: https://play.google.com/store/apps/details?id=dev.smartrobot.bevy_app&hl=en
05-03 10:12:19.851 29974 29974 V GameActivity: onStart_native
05-03 10:12:19.851 29974 29974 V threaded_app: Start: 0x7446f4f1f0
05-03 10:12:19.864 29974 30018 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/srcAdapterInfo { name: "Mali-G76", vendor: 5045, device: 1913716736, device_type: IntegratedGpu, driver: "Mali-G76", driver_info: "v1.r32p1-01bet2-mbs2v39_0.131801e953429f661ecce1d5e1d2b3ef", backend: Vulkan }
05-03 10:12:20.051 29974 30018 I OboeAudio: openStreamInternal() OUTPUT -------- OboeVersion1.8.1 --------
05-03 10:12:20.052 29974 30018 I AAudio  : AAudioStreamBuilder_openStream() called ----------------------------------------
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: rate   =  44100, channels  = 2, format   = 5, sharing = SH, dir = OUTPUT
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: device =      0, sessionId = -1, perfMode = 10, callback: ON with frames = 0
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: usage  =      1, contentType = 2, inputPreset = 6, allowedCapturePolicy = 0
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: privacy sensitive = false
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: opPackageName = (null)
05-03 10:12:20.052 29974 30018 I AudioStreamBuilder: attributionTag = (null)
05-03 10:12:20.052 29974 30018 D AudioStreamBuilder: build() MMAP not used because AAUDIO_PERFORMANCE_MODE_LOW_LATENCY not requested.
05-03 10:12:20.052 29974 30018 D trobot.bevy_ap: PlayerBase::PlayerBase()
05-03 10:12:20.053 29974 30018 D AudioStreamTrack: open(), request notificationFrames = 0, frameCount = 0
05-03 10:12:20.057 29974 30018 D AudioTrack: setVolume(1.000000, 1.000000) pid : 29974
05-03 10:12:20.057 29974 30018 D AAudioStream: setState(s#1) from 0 to 2
05-03 10:12:20.058 29974 30018 I AAudio  : AAudioStreamBuilder_openStream() returns 0 = AAUDIO_OK for s#1 ----------------
05-03 10:12:20.058 29974 30018 D AAudio  : AAudioStream_requestStart(s#1) called --------------
05-03 10:12:20.058 29974 30018 D AAudioStream: setState(s#1) from 2 to 3
05-03 10:12:20.059 29974 29998 D AudioStreamLegacy: onAudioDeviceUpdate(deviceId = 3)
05-03 10:12:20.059 29974 30018 D AAudio  : AAudioStream_requestStart(s#1) returned 0 ---------
05-03 10:12:20.059 26231 26231 D AudioPlayerStateMonitor: Found a new active media playback. AudioPlaybackConfiguration piid:2242847 deviceId:3 type:AAudio u/pid:10728/29974 state:started attr:AudioAttributes: usage=USAGE_MEDIA content=CONTENT_TYPE_UNKNOWN flags=0x0 tags= bundle=null sessionId:-1
05-03 10:12:20.061 29974 30018 E event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_gilrs-0.16.0/src/Failed to start Gilrs. Gilrs does not support current platform.
05-03 10:12:20.100 29974 30018 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_render-0.16.0/srcGPU preprocessing is not supported on this device. Falling back to CPU preprocessing.
05-03 10:12:20.128 29974 30049 D AAudioStream: setState(s#1) from 3 to 4
05-03 10:12:20.130 29974 30018 I event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Creating new window App (0v1)
05-03 10:12:20.130 29974 30018 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Display information:  Window physical resolution: 1280x720  Window logical resolution: 1280x720  Monitor name: Android Device  Scale factor: 3.5  Refresh rate (Hz): 0.000
05-03 10:12:20.130 29974 30018 E event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfCannot get the native window, it's null and will always be null before Event::Resumed and after Event::Suspended. Make sure you only call this function between those events.
05-03 10:12:20.167 29974 30018 V threaded_app: activityState=10
05-03 10:12:20.167 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: forward onStart notification to application
05-03 10:12:20.170 29974 29974 V threaded_app: Resume: 0x7446f4f1f0
05-03 10:12:20.170 29974 30018 V threaded_app: activityState=11
05-03 10:12:20.170 29974 30018 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfApp Resumed - is running
05-03 10:12:20.172 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: ignored. pkg=dev.smartrobot.bevy_app parent=null callers=com.android.internal.policy.DecorView.setVisibility:4294 android.app.ActivityThread.handleResumeActivity:5301 android.app.servertransaction.ResumeActivityItem.execute:54 android.app.servertransaction.ActivityTransactionItem.execute:45 android.app.servertransaction.TransactionExecutor.executeLifecycleState:176
05-03 10:12:20.172 29974 29974 I MSHandlerLifeCycle: removeMultiSplitHandler: no exist. decor=DecorView@9d5c6ee[]
05-03 10:12:20.184   642  3090 I SurfaceFlinger: id=12933 createSurf (0x0),-1 flag=80004, 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity#0
05-03 10:12:20.186 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: setView = com.android.internal.policy.DecorView@9d5c6ee TM=true
05-03 10:12:20.188 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:20.188 29974 29974 I MSHandlerLifeCycle: removeMultiSplitHandler: no exist. decor=DecorView@9d5c6ee[MainActivity]
05-03 10:12:20.195 29974 29974 I SurfaceView@f0c4b33: onWindowVisibilityChanged(0) true com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ......I. 0,0-0,0} of ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:20.198 29974 29974 V threaded_app: WindowInsetsChanged: 0x7446f4f1f0
05-03 10:12:20.199 26231 28072 V WindowManager: Relayout Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}: viewVisibility=0 req=1440x3040 d0
05-03 10:12:20.199   642  3090 I SurfaceFlinger: id=12934 createSurf (1x1),-3 flag=40004, dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0
05-03 10:12:20.200 26231 28072 D WindowManager: makeSurface duration=1 name=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974
05-03 10:12:20.201 26231 28072 V WindowManager: Changing focus from null to Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} displayId=0 Callers=com.android.server.wm.RootWindowContainer.updateFocusedWindowLocked:583 com.android.server.wm.WindowManagerService.updateFocusedWindowLocked:6505 com.android.server.wm.WindowManagerService.relayoutWindow:2770 com.android.server.wm.Session.relayout:242
05-03 10:12:20.201 26231 28072 D MARsPolicyManager: onPackageResumedFG pkgName = dev.smartrobot.bevy_app, userId = 0
05-03 10:12:20.203 26231 28072 V WindowManager: Relayout hash=8af2056, pid=29974: mAttrs={(0,0)(fillxfill) sim={adjust=resize forwardNavigation} ty=BASE_APPLICATION fmt=TRANSLUCENT wanim=0x1030303
05-03 10:12:20.206   642  2162 W ServiceManager: Permission failure: android.permission.ACCESS_SURFACE_FLINGER from uid=10728 pid=29974
05-03 10:12:20.207   642  2162 W ServiceManager: Permission failure: android.permission.ROTATE_SURFACE_FLINGER from uid=10728 pid=29974
05-03 10:12:20.208 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: Relayout returned: old=(0,0,1440,3040) new=(0,0,1440,3040) req=(1440,3040)0 dur=6 res=0x7 s={true 501823046144} ch=true fn=-1
05-03 10:12:20.210 29974 29974 I SurfaceView@f0c4b33: windowStopped(false) true com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ......ID 0,0-1440,3040} of ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:20.210 29974 29974 V threaded_app: ContentRectChanged: 0x7446f4f1f0 -- (0 0) (1440 3040)
05-03 10:12:20.210 29974 30004 D hw-ProcessState: Binder ioctl to enable oneway spam detection failed: Invalid argument
05-03 10:12:20.211 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] dp(1) 1 android.view.ViewRootImpl.reportNextDraw:11420 android.view.ViewRootImpl.performTraversals:4193 android.view.ViewRootImpl.doTraversal:2919
05-03 10:12:20.211 29974 30004 D OpenGLRenderer: eglCreateWindowSurface
05-03 10:12:20.211   642  3090 I SurfaceFlinger: id=12937 createSurf (0x0),-1 flag=20004, Bounds for - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@0#0
05-03 10:12:20.212   642  2162 I SurfaceFlinger: id=12938 createSurf (0x0),-1 flag=80004, SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0
05-03 10:12:20.212   642  2162 I SurfaceFlinger: id=12939 createSurf (0x0),-1 flag=40400, SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:20.212   642  2162 I SurfaceFlinger: id=12940 createSurf (0x0),-1 flag=20404, Background for SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0
05-03 10:12:20.212 29974 29974 I SurfaceView@f0c4b33: pST: sr = Rect(0, 0 - 1440, 3040) sw = 1440 sh = 3040
05-03 10:12:20.212 29974 29974 I SurfaceView@f0c4b33: onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0
05-03 10:12:20.213 29974 29974 I SurfaceView@f0c4b33: pST: mTmpTransaction.apply, mTmpTransaction = android.view.SurfaceControl$Transaction@1361857
05-03 10:12:20.213 29974 29974 I SurfaceView@f0c4b33: updateSurface: mVisible = true mSurface.isValid() = true
05-03 10:12:20.213 29974 29974 I SurfaceView@f0c4b33: updateSurface: mSurfaceCreated = false surfaceChanged = true visibleChanged = true
05-03 10:12:20.213 29974 29974 I SurfaceView@f0c4b33: surfaceCreated 1 #8 com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ......ID 0,0-1440,3040}
05-03 10:12:20.213 29974 29974 V GameActivity: onSurfaceCreated_native
05-03 10:12:20.213 29974 29974 V threaded_app: NativeWindowCreated: 0x7446f4f1f0 -- 0x74d6fb9be0
05-03 10:12:20.213 29974 29974 V threaded_app: android_app_set_window called
05-03 10:12:20.224 26231 28023 D InputDispatcher: Focus request (0): 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity but waiting because NOT_VISIBLE
05-03 10:12:20.228 29974 30029 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_core_pipeline-0.1Downsample depth is not supported on this platform.
05-03 10:12:20.245 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::fullscreen_vertex_shader with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.246 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::fullscreen_vertex_shader with defs: {}
05-03 10:12:20.246 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::fullscreen_vertex_shader with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.247 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.249 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::forward_io with defs: {}
05-03 10:12:20.249 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: handle Android InsetsChanged notification
05-03 10:12:20.249 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: find a way to notify application of content rect change
05-03 10:12:20.249 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_types with defs: {}
05-03 10:12:20.249 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_bindings with defs: {}
05-03 10:12:20.250 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::morph with defs: {}
05-03 10:12:20.251 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::maths with defs: {}
05-03 10:12:20.251 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::view with defs: {}
05-03 10:12:20.252 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_view_types with defs: {"MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 10:12:20.252 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::globals with defs: {}
05-03 10:12:20.253 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_view_bindings with defs: {}
05-03 10:12:20.253 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_bindings with defs: {}
05-03 10:12:20.255 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::view_transformations with defs: {}
05-03 10:12:20.256 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::mesh_functions with defs: {}
05-03 10:12:20.257 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::skinning with defs: {}
05-03 10:12:20.258 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::forward_io with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.262 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::maths with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.265 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_types with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.265 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_bindings with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.269 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::view with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.271 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_view_types with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.272 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::globals with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.272 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_view_bindings with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.273 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::prepass_bindings with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.274 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::view_transformations with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.276 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::mesh_functions with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.276 29974 30018 V threaded_app: APP_CMD_INIT_WINDOW
05-03 10:12:20.276 29974 30018 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_winit-0.16.0/src/Display information:  Window physical resolution: 4480x2520  Window logical resolution: 1280x720  Monitor name: Android Device  Scale factor: 3.5  Refresh rate (Hz): 0.000
05-03 10:12:20.277 29974 29974 I SurfaceView@f0c4b33: surfaceChanged (1440,3040) 1 #8 com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ......ID 0,0-1440,3040}
05-03 10:12:20.277 29974 29974 V threaded_app: NativeWindowResized: 0x7446f4f1f0 -- 0x74d6fb9be0 ( 1440 x 3040 )
05-03 10:12:20.277 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] dp(2) 1 android.view.SurfaceView.updateSurface:1375 android.view.SurfaceView.lambda$new$1$SurfaceView:254 android.view.SurfaceView$$ExternalSyntheticLambda2.onPreDraw:2
05-03 10:12:20.277 29974 29974 V threaded_app: NativeWindowRedrawNeeded: 0x7446f4f1f0 -- 0x74d6fb9be0
05-03 10:12:20.277 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] pdf(1) 1 android.view.SurfaceView.notifyDrawFinished:599 android.view.SurfaceView.performDrawFinished:586 android.view.SurfaceView.$r8$lambda$st27mCkd9jfJkTrN_P3qIGKX6NY:0
05-03 10:12:20.279 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "DEBAND_DITHER": Bool(true), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "VERTEX_NORMALS": Bool(true), "MESH_PIPELINE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VERTEX_POSITIONS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "VERTEX_UVS": Bool(true), "VERTEX_UVS_A": Bool(true), "TONEMAP_IN_SHADER": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.281 29974 30087 I SurfaceView@f0c4b33: uSP: rtp = Rect(0, 0 - 1440, 3040) rtsw = 1440 rtsh = 3040
05-03 10:12:20.281 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_io with defs: {}
05-03 10:12:20.281 29974 30087 I SurfaceView@f0c4b33: onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0
05-03 10:12:20.281 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::meshlet_visibility_buffer_resolve with defs: {}
05-03 10:12:20.281 29974 30087 I SurfaceView@f0c4b33: aOrMT: uB = true t = android.view.SurfaceControl$Transaction@9bd0f44 fN = 1 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionChanged:1728 android.graphics.RenderNode$CompositePositionUpdateListener.positionChanged:319
05-03 10:12:20.281 29974 30087 I SurfaceView@f0c4b33: aOrMT: vR.mWNT, vR = ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:20.281 29974 30087 I ViewRootImpl@320ff7b[MainActivity]: mWNT: t = android.view.SurfaceControl$Transaction@9bd0f44 fN = 1 android.view.SurfaceView.applyOrMergeTransaction:1628 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionChanged:1728
05-03 10:12:20.281 29974 30087 I ViewRootImpl@320ff7b[MainActivity]: mWNT: merge t to BBQ
05-03 10:12:20.282 29974 30004 I Gralloc4: mapper 4.x is not supported
05-03 10:12:20.282 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_types with defs: {}
05-03 10:12:20.284 29974 30004 W Gralloc3: mapper 3.x is not supported
05-03 10:12:20.285 29974 30004 I gralloc : Arm Module v1.0
05-03 10:12:20.286 29974 30004 W Gralloc4: allocator 4.x is not supported
05-03 10:12:20.286 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::lighting with defs: {}
05-03 10:12:20.286 29974 30029 I BufferQueueProducer: [SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#1(BLAST Consumer)1](id:751600000001,api:1,p:29974,c:29974) FrameBooster: VULKAN surface was catched
05-03 10:12:20.286 29974 30029 D trobot.bevy_ap: FrameBooster: InterpolationGui: UID 10728 detected as using Vulkan
05-03 10:12:20.287 29974 30004 W Gralloc3: allocator 3.x is not supported
05-03 10:12:20.287 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::color_operations with defs: {}
05-03 10:12:20.287 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::utils with defs: {}
05-03 10:12:20.289 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::clustered_forward with defs: {}
05-03 10:12:20.292 29974 30029 I BufferQueueProducer: [SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#1(BLAST Consumer)1](id:751600000001,api:1,p:29974,c:29974) FrameBooster: VULKAN surface was catched
05-03 10:12:20.292 29974 30029 D trobot.bevy_ap: FrameBooster: InterpolationGui: UID 10728 detected as using Vulkan
05-03 10:12:20.293 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::shadow_sampling with defs: {}
05-03 10:12:20.294 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::shadows with defs: {}
05-03 10:12:20.295 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::ambient with defs: {}
05-03 10:12:20.296 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::light_probe with defs: {}
05-03 10:12:20.297 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::irradiance_volume with defs: {}
05-03 10:12:20.299 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::environment_map with defs: {}
05-03 10:12:20.299 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::prepass_utils with defs: {}
05-03 10:12:20.300 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::tonemapping_lut_bindings with defs: {}
05-03 10:12:20.302 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::tonemapping with defs: {}
05-03 10:12:20.303 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::transmission with defs: {}
05-03 10:12:20.304 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::fog with defs: {}
05-03 10:12:20.305 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] pdf(0) 1 android.view.ViewRootImpl.lambda$addFrameCompleteCallbackIfNeeded$3$ViewRootImpl:4995 android.view.ViewRootImpl$$ExternalSyntheticLambda16.run:6 android.os.Handler.handleCallback:938
05-03 10:12:20.305 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] rdf()
05-03 10:12:20.305 29974 29974 D ViewRootImpl@320ff7b[MainActivity]: reportDrawFinished (fn: -1)
05-03 10:12:20.306 26231 28023 D WindowManager: finishDrawingWindow: Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} mDrawState=DRAW_PENDING
05-03 10:12:20.307 26231 26250 I WindowManager: Reparenting to leash, surface=Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9, leashParent=Surface(name=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12})/@0xd19e42e
05-03 10:12:20.308   642  3090 I SurfaceFlinger: id=12941 createSurf (0x0),-1 flag=24000, Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal#0
05-03 10:12:20.308 26231 26250 D WindowManager: makeSurface duration=1 leash=Surface(name=Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal)/@0x1205bcf
05-03 10:12:20.309 26231 26246 I PkgPredictorService-SecIpmManagerServiceImpl: reportToNAP uid:10728 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity thisTime:766
05-03 10:12:20.310 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_functions with defs: {}
05-03 10:12:20.310 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::decal::forward with defs: {}
05-03 10:12:20.311 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_bindings with defs: {}
05-03 10:12:20.311 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_render::bindless with defs: {}
05-03 10:12:20.312 26231 27706 D PkgPredictorService-IpmAdcpController: dev.smartrobot.bevy_app become forground, dex profile begin
05-03 10:12:20.312 26231 26246 I ActivityTaskManager: Displayed dev.smartrobot.bevy_app/.MainActivity: +766ms
05-03 10:12:20.312 26231 26246 I Pageboost: Launch time gathered : pid 29974 dev.smartrobot.bevy_app 766
05-03 10:12:20.312 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::parallax_mapping with defs: {}
05-03 10:12:20.312 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::ssao_utils with defs: {}
05-03 10:12:20.313 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::lightmap with defs: {}
05-03 10:12:20.318 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_fragment with defs: {}
05-03 10:12:20.319 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::decal::clustered with defs: {}
05-03 10:12:20.320 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_deferred_types with defs: {}
05-03 10:12:20.320 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::rgb9e5 with defs: {}
05-03 10:12:20.321 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_prepass_functions with defs: {}
05-03 10:12:20.322 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::pbr_deferred_functions with defs: {}
05-03 10:12:20.322 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_core_pipeline::oit with defs: {}
05-03 10:12:20.323 26231 27048 D InputDispatcher: Focus entered window (0): 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity
05-03 10:12:20.324 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: MSG_WINDOW_FOCUS_CHANGED 1 1
05-03 10:12:20.324 29974 29974 V threaded_app: WindowFocusChanged: 0x7446f4f1f0 -- 1
05-03 10:12:20.324 29974 29974 D InsetsSourceConsumer: setRequestedVisible: visible=false, type=21, host=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity, from=android.view.InsetsSourceConsumer.hide:242 android.view.InsetsController.collectSourceControls:1215 android.view.InsetsController.controlAnimationUnchecked:1077 android.view.InsetsController.applyAnimation:1456 android.view.InsetsController.applyAnimation:1437 android.view.InsetsController.hide:1006 android.view.InsetsController.hide:981 dev.smartrobot.bevy_app.MainActivity.hideSystemUi:26 dev.smartrobot.bevy_app.MainActivity.onWindowFocusChanged:19 androidx.appcompat.view.WindowCallbackWrapper.onWindowFocusChanged:125
05-03 10:12:20.324 29974 29974 D InsetsSourceConsumer: setRequestedVisible: visible=false, type=20, host=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity, from=android.view.InsetsSourceConsumer.hide:242 android.view.InsetsController.collectSourceControls:1215 android.view.InsetsController.controlAnimationUnchecked:1077 android.view.InsetsController.applyAnimation:1456 android.view.InsetsController.applyAnimation:1437 android.view.InsetsController.hide:1006 android.view.InsetsController.hide:981 dev.smartrobot.bevy_app.MainActivity.hideSystemUi:26 dev.smartrobot.bevy_app.MainActivity.onWindowFocusChanged:19 androidx.appcompat.view.WindowCallbackWrapper.onWindowFocusChanged:125
05-03 10:12:20.325 26231 27048 V WindowManager: Relayout Window{fcf25c5 u0 Splash Screen dev.smartrobot.bevy_app}: viewVisibility=8 req=1440x3040 d0
05-03 10:12:20.325 26231 27048 I WindowManager: Reparenting to leash, surface=Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5, leashParent=Surface(name=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12})/@0xd19e42e
05-03 10:12:20.326   642  3090 I SurfaceFlinger: id=12942 createSurf (0x0),-1 flag=24000, Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5 - animation-leash of window_animation#0
05-03 10:12:20.326   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd90370 | 0100 | RGBA_8888    |    0.0    0.0 1440.0  114.0 |    0    0 1440  114 | dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0
05-03 10:12:20.326   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd7fe70 | 0100 | RGBA_8888    |    0.0    0.0 1440.0 3040.0 |    0    0 1440 3040 | Splash Screen dev.smartrobot.bevy_app$_26526#0
05-03 10:12:20.326 26231 27048 D WindowManager: makeSurface duration=1 leash=Surface(name=Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5 - animation-leash of window_animation)/@0x97b1fdb
05-03 10:12:20.326 29974 29974 D InsetsSourceConsumer: setRequestedVisible: visible=false, type=1, host=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity, from=android.view.InsetsSourceConsumer.hide:242 android.view.InsetsSourceConsumer.hide:246 android.view.InsetsController.hideDirectly:1473 android.view.InsetsController.controlAnimationUnchecked:1139 android.view.InsetsController.applyAnimation:1456 android.view.InsetsController.applyAnimation:1437 android.view.InsetsController.hide:1006 android.view.InsetsController.hide:981 dev.smartrobot.bevy_app.MainActivity.hideSystemUi:26 dev.smartrobot.bevy_app.MainActivity.onWindowFocusChanged:19
05-03 10:12:20.327 29974 29974 D InsetsSourceConsumer: setRequestedVisible: visible=false, type=0, host=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity, from=android.view.InsetsSourceConsumer.hide:242 android.view.InsetsSourceConsumer.hide:246 android.view.InsetsController.hideDirectly:1473 android.view.InsetsController.controlAnimationUnchecked:1139 android.view.InsetsController.applyAnimation:1456 android.view.InsetsController.applyAnimation:1437 android.view.InsetsController.hide:1006 android.view.InsetsController.hide:981 dev.smartrobot.bevy_app.MainActivity.hideSystemUi:26 dev.smartrobot.bevy_app.MainActivity.onWindowFocusChanged:19
05-03 10:12:20.327 26231 28571 D InsetsSourceProvider: updateVisibility: serverVisible=true, clientVisible=false, source=InsetsSource: {mType=ITYPE_NAVIGATION_BAR, mFrame=[0,3040][1440,3040], mVisible=false, mWindowFrame=[0,2872][1440,3040]}, controlTarget=Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}, from=com.android.server.wm.InsetsSourceProvider.setClientVisible:428 com.android.server.wm.InsetsSourceProvider.updateClientVisibility:413 com.android.server.wm.InsetsStateController.onInsetsModified:508 com.android.server.wm.InsetsPolicy.onInsetsModified:469 com.android.server.wm.Session.insetsModified:704 android.view.IWindowSession$Stub.onTransact:1256 com.android.server.wm.Session.onTransact:176 android.os.Binder.execTransactInternal:1220 android.os.Binder.execTransact:1179 <bottom of call stack>
05-03 10:12:20.328 26231 28571 D InsetsSourceProvider: updateVisibility: serverVisible=true, clientVisible=false, source=InsetsSource: {mType=ITYPE_STATUS_BAR, mFrame=[0,0][1440,114], mVisible=false, mWindowFrame=[0,0][0,0]}, controlTarget=Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}, from=com.android.server.wm.InsetsSourceProvider.setClientVisible:428 com.android.server.wm.InsetsSourceProvider.updateClientVisibility:413 com.android.server.wm.InsetsStateController.onInsetsModified:508 com.android.server.wm.InsetsPolicy.onInsetsModified:469 com.android.server.wm.Session.insetsModified:704 android.view.IWindowSession$Stub.onTransact:1256 com.android.server.wm.Session.onTransact:176 android.os.Binder.execTransactInternal:1220 android.os.Binder.execTransact:1179 <bottom of call stack>
05-03 10:12:20.330 29974 29974 D InputMethodManager: startInputInner - Id : 0
05-03 10:12:20.330 29974 29974 I InputMethodManager: startInputInner - mService.startInputOrWindowGainedFocus
05-03 10:12:20.330 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_types with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.336 29974 29997 I ViewRootImpl@320ff7b[MainActivity]: Resizing android.view.ViewRootImpl@65bb4f: frame=[0,114][1440,3040] reportDraw=false forceLayout=false backDropFrame=Rect(0, 0 - 1440, 2926)
05-03 10:12:20.336 26231 28796 I WindowManager: Cancelling animation restarting=false, leash=Surface(name=Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal)/@0x1205bcf
05-03 10:12:20.336 26231 28796 I WindowManager: Reparenting to original parent: Surface(name=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12})/@0xd19e42e, destroy=false, surface=Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9
05-03 10:12:20.336 26231 28796 W InputManager-JNI: Input channel object 'fcf25c5 Splash Screen dev.smartrobot.bevy_app (client)' was disposed without first being removed with the input manager!
05-03 10:12:20.338   642   642 I Layer   : id=12941 removeFromCurrentState Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal#0 (111)
05-03 10:12:20.339 26231 27048 V InputMethodManagerService: Creating new session for client ClientState{d7edaf uid=10728 pid=29974 displayId=0}
05-03 10:12:20.341 29974 29974 V threaded_app: WindowInsetsChanged: 0x7446f4f1f0
05-03 10:12:20.342   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd90370 | 0100 | RGBA_8888    |    0.0    0.0 1440.0  114.0 |    0  114 1440  228 | dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0
05-03 10:12:20.345 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::lighting with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.345 26231 26250 I WindowManager: Reparenting to original parent: Surface(name=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12})/@0xd19e42e, destroy=true, surface=Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5
05-03 10:12:20.345 26231 26250 E WindowManager: win=Window{fcf25c5 u0 Splash Screen dev.smartrobot.bevy_app EXITING} destroySurfaces: appStopped=false win.mWindowRemovalAllowed=true win.mRemoveOnExit=true win.mViewVisibility=8 caller=com.android.server.wm.ActivityRecord.destroySurfaces:5848 com.android.server.wm.ActivityRecord.destroySurfaces:5829 com.android.server.wm.WindowState.onExitAnimationDone:5968 com.android.server.wm.WindowStateAnimator.onAnimationFinished:242 com.android.server.wm.WindowState.onAnimationFinished:6221 com.android.server.wm.WindowContainer$$ExternalSyntheticLambda0.onAnimationFinished:2 com.android.server.wm.SurfaceAnimator.lambda$getFinishedCallback$0$SurfaceAnimator:113
05-03 10:12:20.345 24309 24309 I HBD     : HoneyBoardService [IMI] onStartInput - caller pid : 29974 , caller uid : 10728
05-03 10:12:20.345 26231 26250 I WindowManager: Destroying surface Surface(name=Splash Screen dev.smartrobot.bevy_app$_26526)/@0x7bfb5cb called by com.android.server.wm.WindowStateAnimator.destroySurface:987 com.android.server.wm.WindowStateAnimator.destroySurfaceLocked:518 com.android.server.wm.WindowState.destroySurfaceUnchecked:4229 com.android.server.wm.WindowState.destroySurface:4203 com.android.server.wm.ActivityRecord.destroySurfaces:5848 com.android.server.wm.ActivityRecord.destroySurfaces:5829 com.android.server.wm.WindowState.onExitAnimationDone:5968 com.android.server.wm.WindowStateAnimator.onAnimationFinished:242
05-03 10:12:20.350 26231 27048 V WindowManager: Relayout Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}: viewVisibility=0 req=1440x3040 d0
05-03 10:12:20.353 26231 27048 V WindowManager: Relayout hash=8af2056, pid=29974: mAttrs={(0,0)(fillxfill) sim={adjust=resize} ty=BASE_APPLICATION fmt=TRANSLUCENT wanim=0x1030303
05-03 10:12:20.355   642   642 I Layer   : id=12927 removeFromCurrentState Splash Screen dev.smartrobot.bevy_app$_26526#0 (112)
05-03 10:12:20.355   642   642 I Layer   : id=12926 removeFromCurrentState fcf25c5 Splash Screen dev.smartrobot.bevy_app#0 (112)
05-03 10:12:20.355   642   642 I Layer   : id=12942 removeFromCurrentState Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5 - animation-leash of window_animation#0 (112)
05-03 10:12:20.356   642   642 I SurfaceFlinger: id=12926 Removed fcf25c5 Splash Screen dev.smartrobot.bevy_app#0 (112)
05-03 10:12:20.356   642   642 I SurfaceFlinger: id=12927 Removed Splash Screen dev.smartrobot.bevy_app$_26526#0 (112)
05-03 10:12:20.356   642   642 I SurfaceFlinger: id=12942 Removed Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5 - animation-leash of window_animation#0 (112)
05-03 10:12:20.356 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: Relayout returned: old=(0,0,1440,3040) new=(0,114,1440,3040) req=(1440,3040)0 dur=11 res=0x1 s={true 501823046144} ch=false fn=2
05-03 10:12:20.356   642   642 I Layer   : id=12942 Destroyed Surface(name=fcf25c5 Splash Screen dev.smartrobot.bevy_app)/@0x37e10d5 - animation-leash of window_animation#0
05-03 10:12:20.356   642   642 I Layer   : id=12926 Destroyed fcf25c5 Splash Screen dev.smartrobot.bevy_app#0
05-03 10:12:20.357   642   642 I Layer   : id=12927 Destroyed Splash Screen dev.smartrobot.bevy_app$_26526#0
05-03 10:12:20.357 29974 29974 V threaded_app: WindowInsetsChanged: 0x7446f4f1f0
05-03 10:12:20.357 29974 30004 D OpenGLRenderer: setSurface() destroyed EGLSurface
05-03 10:12:20.358 29974 30004 D OpenGLRenderer: destroyEglSurface
05-03 10:12:20.358 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: updateBoundsLayer: t = android.view.SurfaceControl$Transaction@6416fe5 sc = Surface(name=Bounds for - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@0)/@0xa129aba frame = 2
05-03 10:12:20.359 29974 30004 D OpenGLRenderer: eglCreateWindowSurface
05-03 10:12:20.359 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: mWNT: t = android.view.SurfaceControl$Transaction@6416fe5 fN = 2 android.view.ViewRootImpl.prepareSurfaces:2778 android.view.ViewRootImpl.performTraversals:4024 android.view.ViewRootImpl.doTraversal:2919
05-03 10:12:20.359 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: mWNT: merge t to BBQ
05-03 10:12:20.360   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd90370 | 0100 | RGBA_8888    |    0.0    0.0 1440.0  114.0 |    0  114 1440  228 | dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0
05-03 10:12:20.360 29974 29974 I SurfaceView@f0c4b33: pST: sr = Rect(0, 0 - 1440, 2926) sw = 1440 sh = 2926
05-03 10:12:20.360 29974 29974 I SurfaceView@f0c4b33: onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0
05-03 10:12:20.360 29974 29974 I SurfaceView@f0c4b33: pST: mTmpTransaction.apply, mTmpTransaction = android.view.SurfaceControl$Transaction@1361857
05-03 10:12:20.361 29974 29974 I SurfaceView@f0c4b33: updateSurface: mVisible = true mSurface.isValid() = true
05-03 10:12:20.361 29974 29974 I SurfaceView@f0c4b33: updateSurface: mSurfaceCreated = true surfaceChanged = false visibleChanged = false
05-03 10:12:20.361 29974 29974 I SurfaceView@f0c4b33: surfaceChanged (1440,2926) 1 #5 com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ......ID 0,0-1440,2926}
05-03 10:12:20.361 29974 29974 V threaded_app: NativeWindowResized: 0x7446f4f1f0 -- 0x74d6fb9be0 ( 1440 x 2926 )
05-03 10:12:20.361 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] dp(1) 1 android.view.SurfaceView.updateSurface:1375 android.view.SurfaceView.setFrame:675 android.view.View.layout:24458
05-03 10:12:20.361 29974 29974 V threaded_app: NativeWindowRedrawNeeded: 0x7446f4f1f0 -- 0x74d6fb9be0
05-03 10:12:20.362 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] pdf(0) 1 android.view.SurfaceView.notifyDrawFinished:599 android.view.SurfaceView.performDrawFinished:586 android.view.SurfaceView.$r8$lambda$st27mCkd9jfJkTrN_P3qIGKX6NY:0
05-03 10:12:20.362 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: [DP] rdf()
05-03 10:12:20.362 29974 29974 D ViewRootImpl@320ff7b[MainActivity]: reportDrawFinished (fn: 2)
05-03 10:12:20.362 26231 28571 D WindowManager: finishDrawingWindow: Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} mDrawState=HAS_DRAWN
05-03 10:12:20.363 29974 29974 V threaded_app: ContentRectChanged: 0x7446f4f1f0 -- (0 0) (1440 2926)
05-03 10:12:20.364 29974 30087 I SurfaceView@f0c4b33: uSP: rtp = Rect(0, 0 - 1440, 2926) rtsw = 1440 rtsh = 2926
05-03 10:12:20.364 29974 30087 I SurfaceView@f0c4b33: onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0
05-03 10:12:20.364 29974 30087 I SurfaceView@f0c4b33: aOrMT: uB = true t = android.view.SurfaceControl$Transaction@aecbd6b fN = 2 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionChanged:1728 android.graphics.RenderNode$CompositePositionUpdateListener.positionChanged:319
05-03 10:12:20.364 29974 30087 I SurfaceView@f0c4b33: aOrMT: vR.mWNT, vR = ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:20.364 29974 30087 I ViewRootImpl@320ff7b[MainActivity]: mWNT: t = android.view.SurfaceControl$Transaction@aecbd6b fN = 2 android.view.SurfaceView.applyOrMergeTransaction:1628 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionChanged:1728
05-03 10:12:20.364 29974 30087 I ViewRootImpl@320ff7b[MainActivity]: mWNT: merge t to BBQ
05-03 10:12:20.366 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: handleResized, msg = 4 frames=ClientWindowFrames{frame=[0,114][1440,3040] display=[0,114][1440,3040] backdrop=[0,0][1440,2926]} forceNextWindowRelayout=false displayId=0 frameChanged=false backdropFrameChanged=true configChanged=false displayChanged=false mNextDrawUseBlastSync=false mergedConfiguration={mGlobalConfig={1.1 ?mcc?mnc [en_US] ldltr sw411dp w411dp h836dp 560dpi nrml long hdr widecg port night finger -keyb/v/h -nav/h winConfig={ mBounds=Rect(0, 0 - 1440, 3040) mAppBounds=Rect(0, 113 - 1440, 3040) mMaxBounds=Rect(0, 0 - 1440, 3040) mWindowingMode=fullscreen mDisplayWindowingMode=fullscreen mActivityType=undefined mAlwaysOnTop=undefined mRotation=ROTATION_0 mPopOver=off mFreeformTaskPinningState=unpinned} s.38 fontWeightAdjustment=0 ff=0 bf=0 bts=0 desktop/d dm/n dc/d ?dcui ?dcaf enb/d themeSeq=0} mOverrideConfig={1.1 ?mcc?mnc [en_US] ldltr sw411dp w411dp h836dp 560dpi nrml long hdr widecg port night finger -keyb/v/h -nav/h winConfig={ mBounds=Rect(0, 0 - 1440, 3040) mAppBounds=Rect(0, 113 - 1440, 3040) mMaxBounds=Rect(0, 0 - 1440, 3040) mWindowingMode=fullscreen mDisplayWindowingMode=fullscreen mActivityType=standard mAlwaysOnTop=undefined mRotation=ROTATION_0 mPopOver=off mFreeformTaskPinningState=unpinned} s.1 fontWeightAdjustment=0 ff=0 bf=0 bts=0 desktop/d dm/n dc/d ?dcui ?dcaf enb/d themeSeq=0}}
05-03 10:12:20.367 29974 29974 D InputMethodManager: startInputInner - Id : 0
05-03 10:12:20.377 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::clustered_forward with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.391 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::utils with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.393 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::shadow_sampling with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.400 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_render::color_operations with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.401 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::shadows with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.405 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::ambient with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.411 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping_lut_bindings with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.411 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.415 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_functions with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.422 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_bindings with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.423 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::pbr_fragment with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.430 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::decal::clustered with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.432 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "IRRADIANCE_VOLUMES_ARE_USABLE": Bool(true), "MAX_CASCADES_PER_LIGHT": UInt(4), "VIEW_PROJECTION_PERSPECTIVE": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(26), "VERTEX_OUTPUT_INSTANCE_INDEX": Bool(true), "SHADOW_FILTER_METHOD_GAUSSIAN": Bool(true), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(27), "VERTEX_POSITIONS": Bool(true), "VERTEX_UVS": Bool(true), "DEBAND_DITHER": Bool(true), "MESH_PIPELINE": Bool(true), "VERTEX_NORMALS": Bool(true), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "SCREEN_SPACE_SPECULAR_TRANSMISSION_BLUR_TAPS": Int(8), "TONEMAP_IN_SHADER": Bool(true), "VERTEX_UVS_A": Bool(true)}
05-03 10:12:20.445 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.467 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"ANTI_ALIAS": Bool(true), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.486 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::types with defs: {}
05-03 10:12:20.487 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::bindings with defs: {}
05-03 10:12:20.487 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::bruneton_functions with defs: {}
05-03 10:12:20.490 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/coadding module definition for bevy_pbr::atmosphere::functions with defs: {}
05-03 10:12:20.491 26231 26560 D MdnieScenarioControlService:  packageName : dev.smartrobot.bevy_app    className : dev.smartrobot.bevy_app.MainActivity
05-03 10:12:20.492 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::types with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.492 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::bindings with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.495 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::bruneton_functions with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.501 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_pbr::atmosphere::functions with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.507 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_DIRECTIONAL_LIGHTS": UInt(10), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.528 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 10:12:20.575 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"MAX_DIRECTIONAL_LIGHTS": UInt(10), "AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_CASCADES_PER_LIGHT": UInt(4)}
05-03 10:12:20.613 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "MAX_CASCADES_PER_LIGHT": UInt(4), "MAX_DIRECTIONAL_LIGHTS": UInt(10)}
05-03 10:12:20.656 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping_lut_bindings with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(3), "DEBAND_DITHER": Bool(true), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "TONEMAPPING_PASS": Bool(true)}
05-03 10:12:20.657 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for bevy_core_pipeline::tonemapping with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(3), "DEBAND_DITHER": Bool(true), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "TONEMAPPING_PASS": Bool(true)}
05-03 10:12:20.660 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35), "TONEMAPPING_LUT_SAMPLER_BINDING_INDEX": UInt(4), "TONEMAPPING_LUT_TEXTURE_BINDING_INDEX": UInt(3), "DEBAND_DITHER": Bool(true), "TONEMAP_METHOD_TONY_MC_MAPFACE": Bool(true), "TONEMAPPING_PASS": Bool(true)}
05-03 10:12:20.670 29974 30025 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.673 29974 30027 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/naga_oil-0.17.0/src/cocreating IR for  with defs: {"AVAILABLE_STORAGE_BUFFER_BINDINGS": UInt(35)}
05-03 10:12:20.712 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: handle Android InsetsChanged notification
05-03 10:12:20.714 29974 30034 I BufferQueueProducer: [SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#1(BLAST Consumer)1](id:751600000001,api:1,p:29974,c:29974) FrameBooster: VULKAN surface was catched
05-03 10:12:20.714 29974 30034 D trobot.bevy_ap: FrameBooster: InterpolationGui: UID 10728 detected as using Vulkan
05-03 10:12:20.728   642   642 D SurfaceFlinger:      CLIENT | 0x6e7fd99eb0 | 0102 | RGBA_8888    |    0.0    0.0 4480.0 2520.0 |    0  114 1440 3040 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:20.850 26231 26249 D SGM:GameManager: identifyForegroundApp. dev.smartrobot.bevy_app, mCurrentUserId: 0, callerUserId: 0
05-03 10:12:20.850 26231 26249 D SGM:PkgDataHelper: getGamePkgData(). dev.smartrobot.bevy_app
05-03 10:12:20.877 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: handle Android InsetsChanged notification
05-03 10:12:20.928 29974 30034 I BufferQueueProducer: [SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#1(BLAST Consumer)1](id:751600000001,api:1,p:29974,c:29974) FrameBooster: VULKAN surface was catched
05-03 10:12:20.928 29974 30034 D trobot.bevy_ap: FrameBooster: InterpolationGui: UID 10728 detected as using Vulkan
05-03 10:12:21.003 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: find a way to notify application of content rect change
05-03 10:12:22.332 26231 27691 D PkgPredictorService-IpmNapPreloadController: app:0_&_com.android.settings die, remove from <launchTime:2025-05-03 10:12:19 hour:10 day:7 previous:[dev.smartrobot.bevy_app, dev.smartrobot.bevy_app, com.android.settings] running:dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity apkVersion:1.0 userId:0 screenOrientation:0 wifi:3 bt:0 predictTime:11 launching Time:766 predicted:false prediction:[0_&_com.android.settings, 0_&_com.netflix.mediaclient, 0_&_com.whatsapp] preloaded:false preloading:[0_&_com.android.settings, 0_&_com.netflix.mediaclient]>
05-03 10:12:23.807 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x0, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:23.810 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 0
05-03 10:12:23.810 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.823 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srSpawning pointer Touch(0)
05-03 10:12:23.845 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.862 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.878 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.895 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.898 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x1, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:23.898 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 1
05-03 10:12:23.898 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:23.906 29974 30034 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srDespawning pointer Touch(0)
05-03 10:12:23.920 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srUnable to get location for pointer Touch(0) during pointer out
05-03 10:12:24.656 26231 26500 I Pageboost: IoRecord pid : 29974
05-03 10:12:24.660 26231 26500 I Pageboost: IoRecord pid : 29974, result_size : 10508
05-03 10:12:24.662 26231 26500 I Pageboost: db create : CREATE TABLE IF NOT EXISTS devsmartrobotbevy_app (FILENAME TEXT, OFFSET INTEGER, SIZE INTEGER, FORVRAMDISK INTEGER, BITMAP BLOB, unique (FILENAME, OFFSET) );
05-03 10:12:24.671 26231 26500 I Pageboost: db create : CREATE TABLE IF NOT EXISTS devsmartrobotbevy_app (FILENAME TEXT, OFFSET INTEGER, SIZE INTEGER, FORVRAMDISK INTEGER, BITMAP BLOB, unique (FILENAME, OFFSET) );
05-03 10:12:24.681 26231 26500 I Pageboost: db update :dev.smartrobot.bevy_app ret 1
05-03 10:12:24.782 26231 26500 I Pageboost: memUsage collected : 159923 33463 1656 for dev.smartrobot.bevy_app 29974
05-03 10:12:25.650 26231 31038 D SGM:GameManager: identifyGamePackage. dev.smartrobot.bevy_app, mCurrentUserId: 0, callerUserId: 0, callingMethodInfo: com.android.server.ssrm.SortingMachine.isGame(SortingMachine.java:162)
05-03 10:12:25.650 26231 31038 D SGM:PkgDataHelper: getGamePkgData(). dev.smartrobot.bevy_app
05-03 10:12:25.869 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x0, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:25.870 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 0
05-03 10:12:25.870 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:25.872 29974 30034 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srSpawning pointer Touch(0)
05-03 10:12:25.898 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:25.948 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:25.965 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:25.982 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:25.998 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.015 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.032 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.048 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.066 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.071 29974 30542 D ProfileInstaller: Installing profile for dev.smartrobot.bevy_app
05-03 10:12:26.082 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.098 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.115 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.131 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.148 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.165 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.182 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.199 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.215 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.232 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.249 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.265 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.282 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.298 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.316 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.332 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.341 26231 27706 I Process : Sending signal. PID: 29974 SIG: 10
05-03 10:12:26.342 29974 29984 I trobot.bevy_ap: Thread[5,tid=29984,WaitingInMainSignalCatcherLoop,Thread*=0x74c6f4f200,peer=0x13240268,"Signal Catcher"]: reacting to signal 10
05-03 10:12:26.342 29974 29984 I trobot.bevy_ap:
05-03 10:12:26.342 29974 29984 I trobot.bevy_ap: SIGUSR1 forcing GC (no HPROF) and profile save
05-03 10:12:26.349 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.356 29974 29984 I trobot.bevy_ap: Explicit concurrent copying GC freed 1452(115KB) AllocSpace objects, 0(0B) LOS objects, 66% free, 3038KB/9182KB, paused 45us,20us total 14.442ms
05-03 10:12:26.366 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.382 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.399 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.416 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.433 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.449 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.466 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.483 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.499 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.516 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.532 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.550 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.566 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.583 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.599 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.615 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.632 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.649 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.666 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.683 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.700 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.717 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.733 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.750 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.766 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.783 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.799 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.817 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.833 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.850 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.866 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.933 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.951 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.966 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.979 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x1, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:26.980 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:26.980 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 1
05-03 10:12:26.980 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:27.002 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srDespawning pointer Touch(0)
05-03 10:12:27.015 29974 30034 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srUnable to get location for pointer Touch(0) during pointer out
05-03 10:12:28.131 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x0, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:28.131 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 0
05-03 10:12:28.132 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.141 29974 30034 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srSpawning pointer Touch(0)
05-03 10:12:28.185 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.219 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.236 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.269 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.303 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.319 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.324 29974 29974 D [secipm]: mSecIpmManager setProfileLength dev.smartrobot.bevy_app profile:3386
05-03 10:12:28.325 26231 27687 D PkgPredictorService-IpmAdcpController:  prepare a new task for pkg:dev.smartrobot.bevy_app dex2oat
05-03 10:12:28.325 26231 30557 I PkgPredictorService-IpmAdcpController:  start a thread to run dex2oat task for pkg:dev.smartrobot.bevy_app
05-03 10:12:28.330 26231 30557 I PackageDexOptimizer: Running dexopt (dexoptNeeded=1) on: /data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/base.apk pkg=dev.smartrobot.bevy_app isa=arm64 dexoptFlags=boot_complete,debuggable,public,enable_hidden_api_checks targetFilter=verify oatDir=/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/oat classLoaderContext=PCL[]{} async=false
05-03 10:12:28.335 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.343   794 19390 V installd: DexInv: --- BEGIN '/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/base.apk' ---
05-03 10:12:28.344   794 19390 V installd: Running /apex/com.android.art/bin/dex2oat32 in=base.apk out=/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/oat/arm64/base.odex
05-03 10:12:28.353 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.378 30561 30561 I dex2oat32: /apex/com.android.art/bin/dex2oat32 --input-vdex-fd=-1 --output-vdex-fd=10 --classpath-dir=/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA== --class-loader-context=PCL[]{} --compiler-filter=verify --compilation-reason=adcp --max-image-block-size=524288 --resolve-startup-const-strings=true --debuggable --generate-mini-debug-info -j6
05-03 10:12:28.386 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.402 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.419 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.436 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.452 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.470 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.485 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.502 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.519 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.535 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.552 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.570 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.586 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.602 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.619 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.636 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.652 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.669 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.686 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.703 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.719 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.736 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.754 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.769 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.786 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.803 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.820 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.837 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.853 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.870 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.886 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.905 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.920 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.936 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.954 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.970 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:28.987 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.004 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.020 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.024 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x1, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:29.024 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.024 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 1
05-03 10:12:29.024 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.042 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srDespawning pointer Touch(0)
05-03 10:12:29.051 29974 30034 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srUnable to get location for pointer Touch(0) during pointer out
05-03 10:12:29.304   794 19390 V installd: DexInv: --- END '/data/app/~~D5AQRGf9CZ5I9e9-nOvQuQ==/dev.smartrobot.bevy_app-kE7C3dN4QWKzRPQRurQ_MA==/base.apk' (success) ---
05-03 10:12:29.459 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x0, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:29.459 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 0
05-03 10:12:29.460 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.469 29974 30029 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srSpawning pointer Touch(0)
05-03 10:12:29.555 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.571 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.588 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.621 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.638 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.655 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.671 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.688 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.704 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.721 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.738 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.755 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.771 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.788 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.804 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.823 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.829   642   658 I SurfaceFlinger: id=12941 Removed Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal#0 (103)
05-03 10:12:29.838   642   642 I Layer   : id=12941 Destroyed Surface(name=8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity)/@0x562e6a9 - animation-leash of starting_reveal#0
05-03 10:12:29.839 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.854 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.872 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.888 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.905 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.922 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.938 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.943 26231 26247 D WindowManager: requestTransientBars: swipeTarget=Window{6a3640c u0 NavigationBar0}, controlTarget=Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}, canShowTransient=true, restorePositionTypes=0x0, from=com.android.server.wm.DisplayPolicy.access$100:227 com.android.server.wm.DisplayPolicy$1.onSwipeFromBottom:581
05-03 10:12:29.955 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.972 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.976   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd889f0 | 0102 | RGBA_8888    |    0.0    0.0 1440.0 2926.0 |    0  114 1440 3040 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:29.989 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:29.991   642   642 D SurfaceFlinger:      DEVICE | 0x6e7fd8e630 | 0102 | RGBA_8888    |    0.0    0.0 1440.0 2926.0 |    0  114 1440 3040 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:30.005 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.022 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.039 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.055 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.072 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.088 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.105 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.122 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.138 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.156 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.172 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.189 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.206 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.222 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.238 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.255 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.272 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.289 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.306 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.339 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.355 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.373 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.389 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.394 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x1, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:30.394 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.394 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 1
05-03 10:12:30.394 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.413 29974 30030 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srDespawning pointer Touch(0)
05-03 10:12:30.425 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srUnable to get location for pointer Touch(0) during pointer out
05-03 10:12:30.827 26231 26362 I InputDispatcher: Delivering touch to (29974): action: 0x0, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:30.828 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: ViewPostIme pointer 0
05-03 10:12:30.828 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.830 29974 30029 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srSpawning pointer Touch(0)
05-03 10:12:30.873 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.890 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.906 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.923 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.956 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:30.974 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.006 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.023 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.040 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.057 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.074 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.091 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.107 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.108 27039 27039 I RecentsView: onGestureAnimationStart, runningTaskInfo : TaskInfo{userId=0 taskId=12 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=990790576 supportsSplitScreenMultiWindow=true supportsMultiWindow=true resizeMode=1 isResizeable=true token=WCT{android.window.IWindowContainerToken$Stub$Proxy@4198b8} topActivityType=1 pictureInPictureParams=PictureInPictureParams( aspectRatio=null sourceRectHint=null hasSetActions=false isAutoPipEnabled=false isSeamlessResizeEnabled=true) displayCutoutSafeInsets=Rect(0, 113 - 0, 0) topActivityInfo=ActivityInfo{ec64691 dev.smartrobot.bevy_app.MainActivity} launchCookies=[com.android.launcher3.util.ObjectWrapper@91269f6] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=true isVisible=true topActivityInSizeCompat=false locusId= null topLaunchHome=false launchSplitWindowingMode=0 isPairTask=false pairedTaskIds=[] pairWindowingMode=0 pairDockSide=0 isAnimatingByRecent=false originallySupportedSplitScreen=true isAnimatingFreeformToFullscreen=false topActivityInFixedAspectRatio=false isTopTransparentActivity=true}
05-03 10:12:31.113 27039 27039 I RecentsView: showCurrentTask : TaskInfo{userId=0 taskId=12 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=990790576 supportsSplitScreenMultiWindow=true supportsMultiWindow=true resizeMode=1 isResizeable=true token=WCT{android.window.IWindowContainerToken$Stub$Proxy@4198b8} topActivityType=1 pictureInPictureParams=PictureInPictureParams( aspectRatio=null sourceRectHint=null hasSetActions=false isAutoPipEnabled=false isSeamlessResizeEnabled=true) displayCutoutSafeInsets=Rect(0, 113 - 0, 0) topActivityInfo=ActivityInfo{ec64691 dev.smartrobot.bevy_app.MainActivity} launchCookies=[com.android.launcher3.util.ObjectWrapper@91269f6] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=true isVisible=true topActivityInSizeCompat=false locusId= null topLaunchHome=false launchSplitWindowingMode=0 isPairTask=false pairedTaskIds=[] pairWindowingMode=0 pairDockSide=0 isAnimatingByRecent=false originallySupportedSplitScreen=true isAnimatingFreeformToFullscreen=false topActivityInFixedAspectRatio=false isTopTransparentActivity=true}
05-03 10:12:31.121 26231 26329 I InputDispatcher: Delivering touch to (29974): action: 0x3, f=0x0, d=0, '8af2056', t=1 +(0,-114)
05-03 10:12:31.121 26231 26329 I InputDispatcher: Monitor swipe-up (server) is stealing touch from [8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity (server), ]
05-03 10:12:31.122 27039 27039 I RecentsView: onGestureAnimationStart, runningTaskInfo : TaskInfo{userId=0 taskId=12 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=990790576 supportsSplitScreenMultiWindow=true supportsMultiWindow=true resizeMode=1 isResizeable=true token=WCT{android.window.IWindowContainerToken$Stub$Proxy@4198b8} topActivityType=1 pictureInPictureParams=PictureInPictureParams( aspectRatio=null sourceRectHint=null hasSetActions=false isAutoPipEnabled=false isSeamlessResizeEnabled=true) displayCutoutSafeInsets=Rect(0, 113 - 0, 0) topActivityInfo=ActivityInfo{ec64691 dev.smartrobot.bevy_app.MainActivity} launchCookies=[com.android.launcher3.util.ObjectWrapper@91269f6] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=true isVisible=true topActivityInSizeCompat=false locusId= null topLaunchHome=false launchSplitWindowingMode=0 isPairTask=false pairedTaskIds=[] pairWindowingMode=0 pairDockSide=0 isAnimatingByRecent=false originallySupportedSplitScreen=true isAnimatingFreeformToFullscreen=false topActivityInFixedAspectRatio=false isTopTransparentActivity=true}
05-03 10:12:31.122 26231 26329 D WindowManager: Moved rootTask=Task{8b43d42 #1 type=home ?? U=0 visible=false mode=fullscreen translucent=true sz=1} behind rootTask=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:31.122 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:31.122 27039 27039 I RecentsView: showCurrentTask : TaskInfo{userId=0 taskId=12 displayId=0 isRunning=true baseIntent=Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=dev.smartrobot.bevy_app/.MainActivity } baseActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} topActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} origActivity=null realActivity=ComponentInfo{dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} numActivities=1 lastActiveTime=990790576 supportsSplitScreenMultiWindow=true supportsMultiWindow=true resizeMode=1 isResizeable=true token=WCT{android.window.IWindowContainerToken$Stub$Proxy@4198b8} topActivityType=1 pictureInPictureParams=PictureInPictureParams( aspectRatio=null sourceRectHint=null hasSetActions=false isAutoPipEnabled=false isSeamlessResizeEnabled=true) displayCutoutSafeInsets=Rect(0, 113 - 0, 0) topActivityInfo=ActivityInfo{ec64691 dev.smartrobot.bevy_app.MainActivity} launchCookies=[com.android.launcher3.util.ObjectWrapper@91269f6] positionInParent=Point(0, 0) parentTaskId=-1 isFocused=true isVisible=true topActivityInSizeCompat=false locusId= null topLaunchHome=false launchSplitWindowingMode=0 isPairTask=false pairedTaskIds=[] pairWindowingMode=0 pairDockSide=0 isAnimatingByRecent=false originallySupportedSplitScreen=true isAnimatingFreeformToFullscreen=false topActivityInFixedAspectRatio=false isTopTransparentActivity=true}
05-03 10:12:31.125 26231 26329 D WindowManager: rotationForOrientation, orientationSource=ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}
05-03 10:12:31.160 27039 28533 I AppIconSolution: return the original icon because tray option is set to None for dev.smartrobot.bevy_app, isNight = true
05-03 10:12:31.160 27039 28533 I LauncherActivityInfo: packageName: dev.smartrobot.bevy_app, useThemeIcon: true, height: 896, width: 896, density: 560
05-03 10:12:31.163 29974 30032 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/bevy_picking-0.16.0/srDespawning pointer Touch(0)
05-03 10:12:31.171 26231 28571 V WindowManager: Changing focus from Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} to null displayId=0 Callers=com.android.server.wm.RootWindowContainer.updateFocusedWindowLocked:583 com.android.server.wm.WindowManagerService.updateFocusedWindowLocked:6505 com.android.server.wm.WindowManagerService.relayoutWindow:2770 com.android.server.wm.Session.relayout:242
05-03 10:12:31.171 26231 28571 D MARsPolicyManager: onPackageResumedFG pkgName = dev.smartrobot.bevy_app, userId = 0
05-03 10:12:31.174 26231 28571 D InputDispatcher: Focus left window (0): 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity
05-03 10:12:31.175 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: MSG_WINDOW_FOCUS_CHANGED 0 1
05-03 10:12:31.175 29974 29974 V threaded_app: WindowFocusChanged: 0x7446f4f1f0 -- 0
05-03 10:12:31.197   642   642 D SurfaceFlinger:      CLIENT | 0x6e7fd889f0 | 0102 | RGBA_8888    |    0.0    0.0 1440.0 2926.0 |    6  123 1434 3024 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:31.281 26231 26560 D MdnieScenarioControlService:  packageName : dev.smartrobot.bevy_app    className : dev.smartrobot.bevy_app.MainActivity
05-03 10:12:31.760 29974 29974 V threaded_app: WindowInsetsChanged: 0x7446f4f1f0
05-03 10:12:31.760 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: handle Android InsetsChanged notification
05-03 10:12:31.768   642   642 D SurfaceFlinger:      CLIENT | 0x6e7fd9d150 | 0102 | RGBA_8888    |    0.0    0.0 1440.0 2926.0 |   55  196 1385 2900 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:32.134   642   642 D SurfaceFlinger:      CLIENT | 0x6e7fd9d150 | 0102 | RGBA_8888    |    0.0    0.0 1440.0 2924.0 |  287  583 1152 2339 | SurfaceView - dev.smartrobot.bevy_ap[...]_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:32.950 26231 28072 D WindowManager: onAnimationFinished(): targetRootTask=Task{8b43d42 #1 type=home ?? U=0 visible=false mode=fullscreen translucent=false sz=1} targetActivity=ActivityRecord{b9ddbef u0 com.sec.android.app.launcher/.activities.LauncherActivity t8} mRestoreTargetBehindRootTask=Task{f433d55 #12 type=standard A=10728:dev.smartrobot.bevy_app U=0 visible=true mode=fullscreen translucent=false sz=1}
05-03 10:12:32.964 26231 28072 V WindowManager: Setting visibility of Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}: false, caller=com.android.server.wm.WindowContainer.sendAppVisibilityToClients:1110 com.android.server.wm.WindowToken.setClientVisible:448 com.android.server.wm.ActivityRecord.setClientVisible:6991 com.android.server.wm.ActivityRecord.onAnimationFinished:7878 com.android.server.wm.ActivityRecord.postApplyAnimation:5579
05-03 10:12:32.969 29974 29974 V threaded_app: Pause: 0x7446f4f1f0
05-03 10:12:32.969 29974 30018 V threaded_app: activityState=13
05-03 10:12:32.969 29974 30018 D event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfApp Paused - stopped running
05-03 10:12:32.970 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: handleAppVisibility mAppVisible=true visible=false
05-03 10:12:32.973 26231 26249 D SGM:GameManager: notePauseComponent(), received pkgName: dev.smartrobot.bevy_app, userId: 0
05-03 10:12:32.977 29974 29974 I SurfaceView@f0c4b33: onWindowVisibilityChanged(8) false com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ........ 0,0-1440,2926} of ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:32.978 29974 29974 I SurfaceView@f0c4b33: pST: mTmpTransaction.apply, mTmpTransaction = android.view.SurfaceControl$Transaction@1361857
05-03 10:12:32.978 29974 29974 I SurfaceView@f0c4b33: surfaceDestroyed callback.size 1 #2 com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ........ 0,0-1440,2926}
05-03 10:12:32.978 29974 29974 V threaded_app: NativeWindowDestroyed: 0x7446f4f1f0 -- 0x74d6fb9be0
05-03 10:12:32.978 29974 29974 V threaded_app: android_app_set_window called
05-03 10:12:32.978 29974 30018 V threaded_app: APP_CMD_TERM_WINDOW
05-03 10:12:32.989 29974 30018 V threaded_app: APP_CMD_TERM_WINDOW
05-03 10:12:32.989 29974 29974 I SurfaceView@f0c4b33: updateSurface: mVisible = false mSurface.isValid() = true
05-03 10:12:32.990 29974 29974 I SurfaceView@f0c4b33: tryReleaseSurfaces: set mRtReleaseSurfaces = true
05-03 10:12:32.991 29974 30004 I SurfaceView@f0c4b33: 215734107 wPL, frameNr = 0
05-03 10:12:32.992 29974 30004 I SurfaceView@f0c4b33: remove() from RT android.view.SurfaceView$SurfaceViewPositionUpdateListener@cdbd75b Surface(name=SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0)/@0x9a9bf8
05-03 10:12:32.992 29974 30004 I SurfaceView@f0c4b33: remove() com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ........ 0,0-1440,2926} Surface(name=SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0)/@0x9a9bf8
05-03 10:12:32.993 29974 30004 I SurfaceView@f0c4b33: aOrMT: uB = true t = android.view.SurfaceControl$Transaction@6f68e37 fN = 0 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionLost:1785 android.graphics.RenderNode$CompositePositionUpdateListener.positionLost:326
05-03 10:12:32.994 29974 30004 I SurfaceView@f0c4b33: aOrMT: vR.mWNT, vR = ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:32.994 29974 30004 I ViewRootImpl@320ff7b[MainActivity]: mWNT: t = android.view.SurfaceControl$Transaction@6f68e37 fN = 0 android.view.SurfaceView.applyOrMergeTransaction:1628 android.view.SurfaceView.access$500:124 android.view.SurfaceView$SurfaceViewPositionUpdateListener.positionLost:1785
05-03 10:12:32.994 29974 30004 I ViewRootImpl@320ff7b[MainActivity]: mWNT: merge t to BBQ
05-03 10:12:32.995 29974 30004 D OpenGLRenderer: setSurface called with nullptr
05-03 10:12:32.995 29974 30004 D OpenGLRenderer: setSurface() destroyed EGLSurface
05-03 10:12:32.995 29974 30004 D OpenGLRenderer: destroyEglSurface
05-03 10:12:33.000 26231 27273 V WindowManager: Relayout Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}: viewVisibility=8 req=1440x2926 d0
05-03 10:12:33.003 26231 27273 V WindowManager: Relayout hash=8af2056, pid=29974: mAttrs={(0,0)(fillxfill) sim={adjust=resize} ty=BASE_APPLICATION fmt=TRANSLUCENT wanim=0x1030303
05-03 10:12:33.005   642   658 I SurfaceFlinger: id=12937 Removed Bounds for - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@0#0 (104)
05-03 10:12:33.006 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: Relayout returned: old=(0,114,1440,3040) new=(0,114,1440,3040) req=(1440,2926)8 dur=7 res=0x5 s={false 0} ch=true fn=4
05-03 10:12:33.006 29974 29974 I SurfaceView@f0c4b33: windowStopped(true) false com.google.androidgamesdk.GameActivity$InputEnabledSurfaceView{f0c4b33 V.E...... ........ 0,0-1440,2926} of ViewRootImpl@320ff7b[MainActivity]
05-03 10:12:33.006 29974 29974 D SurfaceView@f0c4b33: updateSurface: surface is not valid
05-03 10:12:33.007 29974 29974 D SurfaceView@f0c4b33: updateSurface: surface is not valid
05-03 10:12:33.007 29974 29974 I ViewRootImpl@320ff7b[MainActivity]: stopped(true) old=false
05-03 10:12:33.008 29974 29974 V threaded_app: Stop: 0x7446f4f1f0
05-03 10:12:33.009 29974 30018 V threaded_app: activityState=14
05-03 10:12:33.009 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: forward onStop notification to application
05-03 10:12:33.009   642   642 I Layer   : id=12939 removeFromCurrentState SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0(BLAST)#0 (104)
05-03 10:12:33.009 29974 29974 V threaded_app: SaveInstanceState: 0x7446f4f1f0
05-03 10:12:33.009 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: forward saveState notification to application
05-03 10:12:33.009   642   642 I Layer   : id=12940 removeFromCurrentState Background for SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0 (104)
05-03 10:12:33.010 29974 30018 V threaded_app: APP_CMD_SAVE_STATE
05-03 10:12:33.010   642   642 I Layer   : id=12938 removeFromCurrentState SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0 (104)
05-03 10:12:33.010   642   642 I SurfaceFlinger: id=12939 Removed SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0(BLAST)#0 (104)
05-03 10:12:33.010   642   642 I SurfaceFlinger: id=12940 Removed Background for SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0 (104)
05-03 10:12:33.010   642   642 I SurfaceFlinger: id=12938 Removed SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0 (104)
05-03 10:12:33.010 29974 29974 I MSHandlerLifeCycle: isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=false this: DecorView@9d5c6ee[MainActivity]
05-03 10:12:33.010 29974 29974 I MSHandlerLifeCycle: removeMultiSplitHandler: no exist. decor=DecorView@9d5c6ee[MainActivity]
05-03 10:12:33.010   642   642 I Layer   : id=12938 Destroyed SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0
05-03 10:12:33.010   642   642 I Layer   : id=12940 Destroyed Background for SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0#0
05-03 10:12:33.011   642   642 I Layer   : id=12939 Destroyed SurfaceView - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@f0c4b33@0(BLAST)#0
05-03 10:12:33.014 29974 29974 D InputTransport: Input channel destroyed: 'ClientS', fd=116
05-03 10:12:33.034 29974 29974 D SurfaceView@f0c4b33: updateSurface: surface is not valid
05-03 10:12:33.035 29974 29974 V threaded_app: TrimMemory: 0x7446f4f1f0 20
05-03 10:12:33.037 26231 26329 E WindowManager: win=Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity} destroySurfaces: appStopped=true win.mWindowRemovalAllowed=false win.mRemoveOnExit=false win.mViewVisibility=8 caller=com.android.server.wm.ActivityRecord.destroySurfaces:5848 com.android.server.wm.ActivityRecord.destroySurfaces:5829 com.android.server.wm.ActivityRecord.notifyAppStopped:5893 com.android.server.wm.ActivityRecord.activityStopped:6519 com.android.server.wm.ActivityClientController.activityStopped:253 android.app.IActivityClientController$Stub.onTransact:596 com.android.server.wm.ActivityClientController.onTransact:129
05-03 10:12:33.037 26231 26329 I WindowManager: Destroying surface Surface(name=dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974)/@0xdd4e983 called by com.android.server.wm.WindowStateAnimator.destroySurface:987 com.android.server.wm.WindowStateAnimator.destroySurfaceLocked:518 com.android.server.wm.WindowState.destroySurfaceUnchecked:4229 com.android.server.wm.WindowState.destroySurface:4203 com.android.server.wm.ActivityRecord.destroySurfaces:5848 com.android.server.wm.ActivityRecord.destroySurfaces:5829 com.android.server.wm.ActivityRecord.notifyAppStopped:5893 com.android.server.wm.ActivityRecord.activityStopped:6519
05-03 10:12:33.043   642   642 I Layer   : id=12934 removeFromCurrentState dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0 (102)
05-03 10:12:33.043   642   642 I Layer   : id=12937 removeFromCurrentState Bounds for - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@0#0 (102)
05-03 10:12:33.043   642   642 I SurfaceFlinger: id=12934 Removed dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0 (102)
05-03 10:12:33.043   642   642 I Layer   : id=12934 Destroyed dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity$_29974#0
05-03 10:12:33.043   642   642 I Layer   : id=12937 Destroyed Bounds for - dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity@0#0
05-03 10:12:33.060 26231 28072 W InputDispatcher: Letterbox_top_ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12} has FLAG_SLIPPERY. Please report this in b/157929241
05-03 10:12:35.756 29974 29974 V threaded_app: Destroy: 0x7446f4f1f0
05-03 10:12:35.756 29974 30018 V threaded_app: APP_CMD_DESTROY
05-03 10:12:35.756 29974 30018 W event /home/cavani/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.9/src/platfTODO: forward onDestroy notification to application
05-03 10:12:35.760 26231 26249 I ActivityManager: Killing 29974:dev.smartrobot.bevy_app/u0a728 (adj 850): remove task:remove-task
05-03 10:12:35.760 26231 26249 D ActivityManager: [SD] user menu kill listen remove action name:dev.smartrobot.bevy_app uid:10728
05-03 10:12:35.769 26231 26258 I libprocessgroup: Successfully killed process cgroup uid 10728 pid 29974 in 8ms
05-03 10:12:36.065 26008 26072 I AudioFlinger: removeDlbCodecCallback pid:29974 type:-1
05-03 10:12:36.065 26231 28087 I WindowManager: WIN DEATH: Window{8af2056 u0 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity}
05-03 10:12:36.065 26231 28087 W InputManager-JNI: Input channel object '8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity (client)' was disposed without first being removed with the input manager!
05-03 10:12:36.067 26004 26004 I Zygote  : Process 29974 exited due to signal 9 (Killed)
05-03 10:12:36.071 26231 28082 I ActivityTaskManager: Removing activity ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12 f}}(appDied)  from stack callers=com.android.server.wm.ActivityRecord.handleAppDied:4267 com.android.server.wm.WindowProcessController.handleAppDied:1287 com.android.server.wm.ActivityTaskManagerService$LocalService.handleAppDied:7078 com.android.server.am.ActivityManagerService.handleAppDiedLocked:3647 com.android.server.am.ActivityManagerService.appDiedLocked:3837
05-03 10:12:36.073 26231 28082 W InputManager-JNI: Input channel object 'Letterbox_left_ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12} (client)' was disposed without first being removed with the input manager!
05-03 10:12:36.073 26231 28082 W InputManager-JNI: Input channel object 'Letterbox_top_ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12} (client)' was disposed without first being removed with the input manager!
05-03 10:12:36.074 26231 28082 W InputManager-JNI: Input channel object 'Letterbox_right_ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12} (client)' was disposed without first being removed with the input manager!
05-03 10:12:36.074 26231 28082 W InputManager-JNI: Input channel object 'Letterbox_bottom_ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12} (client)' was disposed without first being removed with the input manager!
05-03 10:12:36.080   642   642 I Layer   : id=12933 removeFromCurrentState 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity#0 (100)
05-03 10:12:36.080   642   642 I Layer   : id=12925 removeFromCurrentState ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}#0 (100)
05-03 10:12:36.080   642   642 I SurfaceFlinger: id=12925 Removed ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}#0 (100)
05-03 10:12:36.080 26231 26249 W ActivityManager: setHasOverlayUi called on unknown pid: 29974
05-03 10:12:36.080   642   642 I SurfaceFlinger: id=12933 Removed 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity#0 (100)
05-03 10:12:36.081   642   642 I Layer   : id=12933 Destroyed 8af2056 dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity#0
05-03 10:12:36.081   642   642 I Layer   : id=12925 Destroyed ActivityRecord{3b8e00c u0 dev.smartrobot.bevy_app/.MainActivity t12}#0
05-03 10:12:36.082 26231 26255 W UsageStatsService: Unexpected activity event reported! (dev.smartrobot.bevy_app/dev.smartrobot.bevy_app.MainActivity event : 23 instanceId : 80321809)
```

</details>


## CI

Workflows:

- Commit:
    - format check, lint, test
- Release:
    - Linux x86_64 binary -> smartrobot-bevy-linux-x86_64
    - Linux aarch64 binary -> smartrobot-bevy-linux-aarch64
    - WASM package (site) -> smartrobot-bevy-web.zip
    - APK package (android) -> smartrobot-bevy.apk
- Deploy
    - Web Package -> GitHub Pages


### Release Assets

```sh
rm -rf dist/v0.0.1/

mkdir -p dist/v0.0.1/



# Linux x86_64 binary release


docker run \
--rm \
-it \
--platform linux/amd64 \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
smartrobot-bevy-ubuntu:latest \
cargo build \
--profile release-lto \
--target x86_64-unknown-linux-gnu \
--features log-max,wayland

ls -alh target/x86_64-unknown-linux-gnu/release-lto/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 44M May  4 12:48 target/x86_64-unknown-linux-gnu/release-lto/smartrobot-bevy*

file -b target/x86_64-unknown-linux-gnu/release-lto/smartrobot-bevy

# ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=7237a657dfe72c8ab4d4ebc13cc09b86234b7714, stripped

docker run --rm --platform linux/amd64 \
-v $PWD:/home/user/project \
smartrobot-bevy-ubuntu:latest \
ldd target/x86_64-unknown-linux-gnu/release-lto/smartrobot-bevy

# linux-vdso.so.1 (0x000074f6c4186000)
# libwayland-client.so.0 => /lib/x86_64-linux-gnu/libwayland-client.so.0 (0x000074f6c4169000)
# libudev.so.1 => /lib/x86_64-linux-gnu/libudev.so.1 (0x000074f6c411b000)
# libasound.so.2 => /lib/x86_64-linux-gnu/libasound.so.2 (0x000074f6c3ff3000)
# libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x000074f6c3fc6000)
# libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x000074f6c1309000)
# libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x000074f6c10e9000)
# libffi.so.8 => /lib/x86_64-linux-gnu/libffi.so.8 (0x000074f6c3fb7000)
# libcap.so.2 => /lib/x86_64-linux-gnu/libcap.so.2 (0x000074f6c3fa9000)
# /lib64/ld-linux-x86-64.so.2 (0x000074f6c4188000)


cp target/x86_64-unknown-linux-gnu/release-lto/smartrobot-bevy \
dist/v0.0.1/smartrobot-bevy-linux-x86_64



# Linux aarch64 binary release


docker run \
--rm \
-it \
--platform linux/arm64 \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
smartrobot-bevy-debian:latest \
cargo build \
--profile release-lto \
--target aarch64-unknown-linux-gnu \
--features log-max,wayland


ls -alh target/aarch64-unknown-linux-gnu/release-lto/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 38M May  4 12:38 target/aarch64-unknown-linux-gnu/release-lto/smartrobot-bevy*

file -b target/aarch64-unknown-linux-gnu/release-lto/smartrobot-bevy

# ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, BuildID[sha1]=613d5badacc2a2fb492d0df3676f5bcc99baa191, stripped

docker run --rm --platform linux/arm64 \
-v $PWD:/home/user/project \
smartrobot-bevy-debian:latest \
ldd target/aarch64-unknown-linux-gnu/release-lto/smartrobot-bevy


# linux-vdso.so.1 (0x00007c236fdd4000)
# libwayland-client.so.0 => /lib/aarch64-linux-gnu/libwayland-client.so.0 (0x00007c236fda0000)
# libudev.so.1 => /lib/aarch64-linux-gnu/libudev.so.1 (0x00007c236ed60000)
# libasound.so.2 => /lib/aarch64-linux-gnu/libasound.so.2 (0x00007c236ec40000)
# libgcc_s.so.1 => /lib/aarch64-linux-gnu/libgcc_s.so.1 (0x00007c23663c0000)
# libm.so.6 => /lib/aarch64-linux-gnu/libm.so.6 (0x00007c2366320000)
# libc.so.6 => /lib/aarch64-linux-gnu/libc.so.6 (0x00007c2366170000)
# libffi.so.8 => /lib/aarch64-linux-gnu/libffi.so.8 (0x00007c236ec10000)
# libpthread.so.0 => /lib/aarch64-linux-gnu/libpthread.so.0 (0x00007c2366140000)
# /lib/ld-linux-aarch64.so.1 (0x00007c236edb0000)


cp target/aarch64-unknown-linux-gnu/release-lto/smartrobot-bevy \
dist/v0.0.1/smartrobot-bevy-linux-aarch64



# WASM package (site)


rm -rf smartrobot-bevy-web/

mkdir -p smartrobot-bevy-web/

cp web/index.html smartrobot-bevy-web/

cargo build \
--profile wasm-release \
--target wasm32-unknown-unknown \
--features log-max

ls -alh target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

# -rwxrwxr-x 2 cavani cavani 25M May  4 11:44 target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

wasm-bindgen \
--out-name smartrobot_bevy \
--out-dir smartrobot-bevy-web/ \
--target web \
target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

ls -alh smartrobot-bevy-web/

# total 23M
# drwxrwxr-x  2 cavani cavani 4.0K May  4 11:52 ./
# drwxrwxr-x 13 cavani cavani 4.0K May  4 11:52 ../
# -rw-rw-r--  1 cavani cavani  212 May  4 11:52 index.html
# -rw-rw-r--  1 cavani cavani 1.8K May  4 11:52 smartrobot_bevy.d.ts
# -rw-rw-r--  1 cavani cavani 105K May  4 11:52 smartrobot_bevy.js
# -rw-rw-r--  1 cavani cavani  23M May  4 11:52 smartrobot_bevy_bg.wasm
# -rw-rw-r--  1 cavani cavani  830 May  4 11:52 smartrobot_bevy_bg.wasm.d.ts

zip -mr smartrobot-bevy-web.zip smartrobot-bevy-web/

ls -alh smartrobot-bevy-web.zip

# -rw-rw-r-- 1 cavani cavani 6.5M May  4 11:55 smartrobot-bevy-web.zip


mv smartrobot-bevy-web.zip dist/v0.0.1/



# APK release


source android-env.sh

rm -rf android/app/src/main/jniLibs/

cargo ndk \
-t arm64-v8a \
-t x86_64 \
-o android/app/src/main/jniLibs \
build \
--lib \
--profile mobile-release \
--features log-max

ls -alh android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# -rwxrwxr-x 1 cavani cavani 29M May  4 12:14 android/app/src/main/jniLibs/arm64-v8a/libsmartrobot_bevy.so*
# -rwxrwxr-x 1 cavani cavani 36M May  4 12:14 android/app/src/main/jniLibs/x86_64/libsmartrobot_bevy.so*

file -b android/app/src/main/jniLibs/{arm64-v8a,x86_64}/libsmartrobot_bevy.so

# ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, stripped
# ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, stripped


cd android/

./gradlew --warning-mode all clean build

cd ..

ls -alh android/app/build/outputs/apk/debug/app-debug.apk

# -rw-rw-r-- 1 cavani cavani 80M May  4 13:11 android/app/build/outputs/apk/debug/app-debug.apk


cp android/app/build/outputs/apk/debug/app-debug.apk \
dist/v0.0.1/smartrobot-bevy.apk



# Release Assets


ls -alh dist/v0.0.1/

# total 165M
# drwxrwxr-x 2 cavani cavani 4.0K May  4 12:41 ./
# drwxrwxr-x 3 cavani cavani 4.0K May  4 11:53 ../
# -rwxr-xr-x 1 cavani cavani  38M May  4 12:41 smartrobot-bevy-linux-aarch64*
# -rwxrwxr-x 1 cavani cavani  44M May  4 12:51 smartrobot-bevy-linux-x86_64*
# -rw-rw-r-- 1 cavani cavani 6.5M May  4 11:55 smartrobot-bevy-web.zip
# -rw-rw-r-- 1 cavani cavani  88M May  4 13:11 smartrobot-bevy.apk
```
