# Bevy Quick Start

Based on:

<https://bevyengine.org/learn/quick-start/>


Development Host:

- Ubuntu 25.04
- Gnome 48 on Wayland
- CPU Intel Core 7 x86_64
- GPU Integrated Intel Graphics
- GPU Discrete NVIDIA GeForce MX570 A 2GB

Targets:

- Ubuntu 25.04 AMD64 (x86_64) -> Development Host
- Debian 12 ARM64 (aarch64) -> Raspberry Pi


## Quick Start Project

```sh
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


# Rust


sudo apt install -y --no-install-recommends curl ca-certificates

curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y

. "$HOME/.cargo/env"


cargo version

# cargo 1.86.0 (adf9b6ad1 2025-02-28)


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
default = ["bevy-dev", "log-max"]
bevy-dev = ["bevy/dynamic_linking"]
log-max = ["log/max_level_debug", "log/release_max_level_warn"]
' \
>> Cargo.toml


# Compile with Performance Optimizations

# https://bevyengine.org/learn/quick-start/getting-started/setup/#compile-with-performance-optimizations


echo '
# Enable a small amount of optimization in the dev profile.
[profile.dev]
opt-level = 1

# Enable a large amount of optimization in the dev profile for dependencies.
[profile.dev.package."*"]
opt-level = 3

# Enable more optimization in the release profile at the cost of compile time.
[profile.release]
# Compile the entire crate as one unit.
# Slows compile times, marginal improvements.
codegen-units = 1
# Do a second optimization pass over the entire program, including dependencies.
# Slows compile times, marginal improvements.
lto = "fat"

# Optimize for size in the wasm-release profile to reduce load times and bandwidth usage on web.
[profile.wasm-release]
# Default to release profile values.
inherits = "release"
# Optimize with size in mind (also try "z", sometimes it is better).
# Slightly slows compile times, great improvements to file size and runtime performance.
opt-level = "z"
# Strip all debugging information from the binary to slightly reduce file size.
strip = "debuginfo"
' \
>> Cargo.toml


# Alternative Linkers

# https://bevyengine.org/learn/quick-start/getting-started/setup/#compile-with-performance-optimizations


# - Ubuntu 25.04 x86_64

sudo apt install -y --no-install-recommends clang lld

clang --version

# Ubuntu clang version 20.1.2 (0ubuntu1)
# Target: x86_64-pc-linux-gnu
# Thread model: posix
# InstalledDir: /usr/lib/llvm-20/bin

# - Raspberry Pi OS (Debian 12)

sudo apt install -y --no-install-recommends clang-19 lld-19

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-19 100
# sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-19 100

clang --version

# Debian clang version 19.1.4 (1~deb12u1)
# Target: aarch64-unknown-linux-gnu
# Thread model: posix
# InstalledDir: /usr/lib/llvm-19/bin

# - Cargo Config

mkdir .cargo/

echo '[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]

[target.aarch64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]
' \
> .cargo/config.toml


# Quick Start Code


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


cargo run --features bevy/wayland

# -> [Output Dev]
```

<details>
<summary>Output Dev.</summary>

```text
cargo run --features bevy/wayland
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
# Docker

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
-t smartrobot-bevy-devel:ubuntu-amd64 \
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
smartrobot-bevy-devel:ubuntu-amd64 \
cargo run --features bevy/wayland

# -> [Output ubuntu-amd64 (Docker)]


file -b target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy

# ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=3a524fd5a08f8a44d1449f0ef95d6841a629eee3, with debug_info, not stripped

ls -alh target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 4.2M Apr 28 12:58 target/x86_64-unknown-linux-gnu/debug/smartrobot-bevy


# Debian 12 ARM64 -> Raspberry Pi

# Docker Host (Ubuntu 25.04 AMD64) running ARM64 container
# docker run --platform linux/arm64

sudo apt install -y --no-install-recommends qemu-user-static binfmt-support

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
-t smartrobot-bevy-devel:debian-arm64 \
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
smartrobot-bevy-devel:debian-arm64 \
cargo run --features bevy/wayland

# -> [Output debian-arm64 (Docker)]


file -b target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy

# ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, BuildID[sha1]=5b8b35673e515c67fad059f50b4fe5b7a4109b36, with debug_info, not stripped

ls -alh target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy

# -rwxr-xr-x 2 cavani cavani 4.2M Apr 28 14:37 target/aarch64-unknown-linux-gnu/debug/smartrobot-bevy
```

<details>
<summary>Output ubuntu-amd64 (Docker).</summary>

```text
cargo run --features bevy/wayland
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
cargo run --features bevy/wayland
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
# Using Docker Development Ubuntu 25.04 AMD64 Image


# NVIDIA Container Toolkit

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg --yes

echo 'deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /' | \
sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

sudo apt update

sudo apt install -y --no-install-recommends nvidia-driver-570
sudo apt install -y --no-install-recommends nvidia-container-toolkit


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
smartrobot-bevy-devel:ubuntu-amd64 \
cargo run --features bevy/wayland

# -> [Output ubuntu-amd64 (NVIDIA)]
```

<details>
<summary>Output ubuntu-amd64 (NVIDIA).</summary>

```text
cargo run --features bevy/wayland
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

cargo run
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
# https://github.com/cargo-bins/cargo-binstall

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

cargo binstall -V

# 1.12.3


rustup target add wasm32-unknown-unknown

cargo binstall -y wasm-bindgen-cli

wasm-bindgen --version

# wasm-bindgen 0.2.100


cargo build \
--profile wasm-release \
--target wasm32-unknown-unknown \
--no-default-features \
--features log-max

ls -alh target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

# -rwxrwxr-x 2 cavani cavani 31M Apr 29 14:11 target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm


rm -rf web-app/

wasm-bindgen \
--out-name smartrobot_bevy \
--out-dir web-app \
--target web \
target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

ls -alh web-app

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
> web-app/index.html


cargo binstall -y simple-http-server

simple-http-server -i web-app/

# -> [Output http-server]


# Google Chrome

# (Ubuntu Snap Firefox does not use NVIDIA discrete CPU by default)
# (Chrome can default to NVIDIA discrete GPU with environment variable configuration)

curl -LO --proto '=https' --tlsv1.2 -sSf https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

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

# -> [Output Ghrome GPU info]
```

<details>
<summary>Output Web Server</summary>

```text
     Index: enabled, Cache: enabled, Cors: disabled, Coop: disabled, Coep: disabled, Range: enabled, Sort: enabled, Threads: 3
          Upload: disabled, CSRF Token:
          Auth: disabled, Compression: disabled
         https: disabled, Cert: , Cert-Password:
          Root: /home/cavani/Workspace/smartrobot-bevy/web-app,
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
