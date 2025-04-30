# Smart Robot - Bevy Experimental Project


> Bevy is a refreshingly simple data-driven game engine built in Rust.

<https://bevyengine.org/>

<https://github.com/bevyengine/bevy>


## Setup

Pre-requisites:

- Rust Toolchain
- Docker Engine / CLI
- Vulkan support
- Wayland window system

...

Ubuntu 25.04 Plucky with NVIDIA GPU:

> WARNING: use with caution

[`setup-ubuntu2504.sh`](./setup-ubuntu2504.sh)


### Build Dependencies

<https://github.com/bevyengine/bevy/blob/main/docs/linux_dependencies.md#ubuntu>

```sh
sudo apt update

sudo apt install -y \
--no-install-recommends \
pkg-config \
libasound2-dev \
libudev-dev \
libx11-dev \
libxkbcommon-x11-0 \
libwayland-dev \
libxkbcommon-dev \
mesa-vulkan-drivers \
mesa-utils \
vulkan-tools
```


### Rust Toolchain

```sh
sudo apt update

sudo apt install -y ca-certificates curl

curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | \
sh -s -- --default-toolchain stable -y


. "$HOME/.cargo/env"

cargo version

# cargo 1.86.0 (adf9b6ad1 2025-02-28)


# Cargo Binary Install

# https://github.com/cargo-bins/cargo-binstall

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

cargo binstall -V

# 1.12.3


# WebAssembly target

rustup target add wasm32-unknown-unknown

cargo binstall -y wasm-bindgen-cli

wasm-bindgen --version

# wasm-bindgen 0.2.100


# HTTP Server

cargo binstall -y simple-http-server

simple-http-server --version

# Simple HTTP(s) Server 0.6.12
```


### Compiler clang / lld

```sh
sudo apt install -y --no-install-recommends clang lld


clang --version

# Ubuntu clang version 20.1.2 (0ubuntu1)
# Target: x86_64-pc-linux-gnu
# Thread model: posix
# InstalledDir: /usr/lib/llvm-20/bin
```


### Docker Engine

<https://docs.docker.com/engine/install/ubuntu/>

```sh
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


docker run --rm ubuntu:25.04 uname -mo

# x86_64 GNU/Linux


docker run \
--rm \
--device /dev/dri \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
ubuntu:25.04 \
sh -c 'export DEBIAN_FRONTEND=noninteractive;
apt update;
apt install -y --no-install-recommends mesa-vulkan-drivers mesa-utils vulkan-tools;
vulkaninfo --summary'

# -> [Output vulkaninfo]
```

<details>
<summary>Output vulkaninfo.</summary>

```text
'DISPLAY' environment variable not set... skipping surface info
==========
VULKANINFO
==========

Vulkan Instance Version: 1.4.304


Instance Extensions: count = 24
-------------------------------
VK_EXT_acquire_drm_display             : extension revision 1
VK_EXT_acquire_xlib_display            : extension revision 1
VK_EXT_debug_report                    : extension revision 10
VK_EXT_debug_utils                     : extension revision 2
VK_EXT_direct_mode_display             : extension revision 1
VK_EXT_display_surface_counter         : extension revision 1
VK_EXT_headless_surface                : extension revision 1
VK_EXT_surface_maintenance1            : extension revision 1
VK_EXT_swapchain_colorspace            : extension revision 5
VK_KHR_device_group_creation           : extension revision 1
VK_KHR_display                         : extension revision 23
VK_KHR_external_fence_capabilities     : extension revision 1
VK_KHR_external_memory_capabilities    : extension revision 1
VK_KHR_external_semaphore_capabilities : extension revision 1
VK_KHR_get_display_properties2         : extension revision 1
VK_KHR_get_physical_device_properties2 : extension revision 2
VK_KHR_get_surface_capabilities2       : extension revision 1
VK_KHR_portability_enumeration         : extension revision 1
VK_KHR_surface                         : extension revision 25
VK_KHR_surface_protected_capabilities  : extension revision 1
VK_KHR_wayland_surface                 : extension revision 6
VK_KHR_xcb_surface                     : extension revision 6
VK_KHR_xlib_surface                    : extension revision 6
VK_LUNARG_direct_driver_loading        : extension revision 1

Instance Layers: count = 3
--------------------------
VK_LAYER_INTEL_nullhw       INTEL NULL HW                1.1.73   version 1
VK_LAYER_MESA_device_select Linux device selection layer 1.4.303  version 1
VK_LAYER_MESA_overlay       Mesa Overlay layer           1.4.303  version 1

Devices:
========
GPU0:
        apiVersion         = 1.4.305
        driverVersion      = 25.0.3
        vendorID           = 0x8086
        deviceID           = 0xa7ac
        deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
        deviceName         = Intel(R) Graphics (RPL-U)
        driverID           = DRIVER_ID_INTEL_OPEN_SOURCE_MESA
        driverName         = Intel open-source Mesa driver
        driverInfo         = Mesa 25.0.3-1ubuntu2
        conformanceVersion = 1.4.0.0
        deviceUUID         = 8680aca7-0400-0000-0002-000000000000
        driverUUID         = b7bfe4ab-94df-c0d4-616d-43a427c11fca
GPU1:
        apiVersion         = 1.4.305
        driverVersion      = 0.0.1
        vendorID           = 0x10005
        deviceID           = 0x0000
        deviceType         = PHYSICAL_DEVICE_TYPE_CPU
        deviceName         = llvmpipe (LLVM 19.1.7, 256 bits)
        driverID           = DRIVER_ID_MESA_LLVMPIPE
        driverName         = llvmpipe
        driverInfo         = Mesa 25.0.3-1ubuntu2 (LLVM 19.1.7)
        conformanceVersion = 1.3.1.1
        deviceUUID         = 6d657361-3235-2e30-2e33-2d3175627500
        driverUUID         = 6c6c766d-7069-7065-5555-494400000000
```
</details>


### Docker ARM64

```sh
sudo apt install -y --no-install-recommends qemu-user-static binfmt-support


docker run --rm --platform linux/arm64 debian:12 uname -mo

# aarch64 GNU/Linux


docker run \
--rm \
--platform linux/arm64 \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
debian:12 \
sh -c 'export DEBIAN_FRONTEND=noninteractive;
apt update;
apt install -y --no-install-recommends mesa-vulkan-drivers mesa-utils vulkan-tools;
vulkaninfo --summary'

# -> [Output vulkaninfo]
```

<details>
<summary>Output vulkaninfo.</summary>

```text
'DISPLAY' environment variable not set... skipping surface info
==========
VULKANINFO
==========

Vulkan Instance Version: 1.3.239


Instance Extensions: count = 20
-------------------------------
VK_EXT_acquire_drm_display             : extension revision 1
VK_EXT_acquire_xlib_display            : extension revision 1
VK_EXT_debug_report                    : extension revision 10
VK_EXT_debug_utils                     : extension revision 2
VK_EXT_direct_mode_display             : extension revision 1
VK_EXT_display_surface_counter         : extension revision 1
VK_KHR_device_group_creation           : extension revision 1
VK_KHR_display                         : extension revision 23
VK_KHR_external_fence_capabilities     : extension revision 1
VK_KHR_external_memory_capabilities    : extension revision 1
VK_KHR_external_semaphore_capabilities : extension revision 1
VK_KHR_get_display_properties2         : extension revision 1
VK_KHR_get_physical_device_properties2 : extension revision 2
VK_KHR_get_surface_capabilities2       : extension revision 1
VK_KHR_portability_enumeration         : extension revision 1
VK_KHR_surface                         : extension revision 25
VK_KHR_surface_protected_capabilities  : extension revision 1
VK_KHR_wayland_surface                 : extension revision 6
VK_KHR_xcb_surface                     : extension revision 6
VK_KHR_xlib_surface                    : extension revision 6

Instance Layers: count = 2
--------------------------
VK_LAYER_MESA_device_select Linux device selection layer 1.3.211  version 1
VK_LAYER_MESA_overlay       Mesa Overlay layer           1.3.211  version 1

Devices:
========
GPU0:
        apiVersion         = 1.3.230
        driverVersion      = 0.0.1
        vendorID           = 0x10005
        deviceID           = 0x0000
        deviceType         = PHYSICAL_DEVICE_TYPE_CPU
        deviceName         = llvmpipe (LLVM 15.0.6, 128 bits)
        driverID           = DRIVER_ID_MESA_LLVMPIPE
        driverName         = llvmpipe
        driverInfo         = Mesa 22.3.6 (LLVM 15.0.6)
        conformanceVersion = 1.3.1.1
        deviceUUID         = 6d657361-3232-2e33-2e36-000000000000
        driverUUID         = 6c6c766d-7069-7065-5555-494400000000
```
</details>


### Docker NVIDIA GPU

<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>

```sh
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg --yes

echo 'deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /' | \
sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

sudo apt update

sudo apt install -y --no-install-recommends nvidia-driver-570
sudo apt install -y --no-install-recommends nvidia-container-toolkit

# reboot


docker run --rm --runtime nvidia --gpus all ubuntu:25.04 nvidia-smi

# -> [Output nvidia-smi]

docker run --rm \
--runtime nvidia \
--gpus all \
--device /dev/dri \
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
-v /etc/machine-id:/etc/machine-id:ro \
ubuntu:25.04 \
sh -c 'export DEBIAN_FRONTEND=noninteractive;
apt update;
apt install -y --no-install-recommends mesa-vulkan-drivers mesa-utils vulkan-tools;
vulkaninfo --summary'

# -> [Output vulkaninfo]
```

<details>
<summary>Output nvidia-smi.</summary>

```text
Tue Apr 29 14:12:52 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 570.133.07             Driver Version: 570.133.07     CUDA Version: 12.8     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce MX570 A         Off |   00000000:01:00.0 Off |                  N/A |
| N/A   48C    P8              3W /    8W |      11MiB /   2048MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
+-----------------------------------------------------------------------------------------+
```
</details>

<details>
<summary>Output vulkaninfo.</summary>

```text
'DISPLAY' environment variable not set... skipping surface info
==========
VULKANINFO
==========

Vulkan Instance Version: 1.4.304


Instance Extensions: count = 25
-------------------------------
VK_EXT_acquire_drm_display             : extension revision 1
VK_EXT_acquire_xlib_display            : extension revision 1
VK_EXT_debug_report                    : extension revision 10
VK_EXT_debug_utils                     : extension revision 2
VK_EXT_direct_mode_display             : extension revision 1
VK_EXT_display_surface_counter         : extension revision 1
VK_EXT_headless_surface                : extension revision 1
VK_EXT_surface_maintenance1            : extension revision 1
VK_EXT_swapchain_colorspace            : extension revision 5
VK_KHR_device_group_creation           : extension revision 1
VK_KHR_display                         : extension revision 23
VK_KHR_external_fence_capabilities     : extension revision 1
VK_KHR_external_memory_capabilities    : extension revision 1
VK_KHR_external_semaphore_capabilities : extension revision 1
VK_KHR_get_display_properties2         : extension revision 1
VK_KHR_get_physical_device_properties2 : extension revision 2
VK_KHR_get_surface_capabilities2       : extension revision 1
VK_KHR_portability_enumeration         : extension revision 1
VK_KHR_surface                         : extension revision 25
VK_KHR_surface_protected_capabilities  : extension revision 1
VK_KHR_wayland_surface                 : extension revision 6
VK_KHR_xcb_surface                     : extension revision 6
VK_KHR_xlib_surface                    : extension revision 6
VK_LUNARG_direct_driver_loading        : extension revision 1
VK_NV_display_stereo                   : extension revision 1

Instance Layers: count = 4
--------------------------
VK_LAYER_INTEL_nullhw       INTEL NULL HW                1.1.73   version 1
VK_LAYER_MESA_device_select Linux device selection layer 1.4.303  version 1
VK_LAYER_MESA_overlay       Mesa Overlay layer           1.4.303  version 1
VK_LAYER_NV_optimus         NVIDIA Optimus layer         1.4.303  version 1

Devices:
========
GPU0:
        apiVersion         = 1.4.305
        driverVersion      = 25.0.3
        vendorID           = 0x8086
        deviceID           = 0xa7ac
        deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
        deviceName         = Intel(R) Graphics (RPL-U)
        driverID           = DRIVER_ID_INTEL_OPEN_SOURCE_MESA
        driverName         = Intel open-source Mesa driver
        driverInfo         = Mesa 25.0.3-1ubuntu2
        conformanceVersion = 1.4.0.0
        deviceUUID         = 8680aca7-0400-0000-0002-000000000000
        driverUUID         = b7bfe4ab-94df-c0d4-616d-43a427c11fca
GPU1:
        apiVersion         = 1.4.303
        driverVersion      = 570.133.7.0
        vendorID           = 0x10de
        deviceID           = 0x25aa
        deviceType         = PHYSICAL_DEVICE_TYPE_DISCRETE_GPU
        deviceName         = NVIDIA GeForce MX570 A
        driverID           = DRIVER_ID_NVIDIA_PROPRIETARY
        driverName         = NVIDIA
        driverInfo         = 570.133.07
        conformanceVersion = 1.4.1.0
        deviceUUID         = ffacb06a-ba56-5cc1-58da-90cadf3cc4e0
        driverUUID         = a312329b-a338-5885-bebf-8b95ca9ae741
GPU2:
        apiVersion         = 1.4.305
        driverVersion      = 0.0.1
        vendorID           = 0x10005
        deviceID           = 0x0000
        deviceType         = PHYSICAL_DEVICE_TYPE_CPU
        deviceName         = llvmpipe (LLVM 19.1.7, 256 bits)
        driverID           = DRIVER_ID_MESA_LLVMPIPE
        driverName         = llvmpipe
        driverInfo         = Mesa 25.0.3-1ubuntu2 (LLVM 19.1.7)
        conformanceVersion = 1.3.1.1
        deviceUUID         = 6d657361-3235-2e30-2e33-2d3175627500
        driverUUID         = 6c6c766d-7069-7065-5555-494400000000
```
</details>


## Google Chrome (NVIDIA CPU)

> NOTE
>
> - Ubuntu Snap Firefox does not use NVIDIA discrete CPU by default
> - Chrome can default to NVIDIA discrete GPU with environment variable configuration

```sh
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

google-chrome chrome://gpu/

# -> [Output Chrome GPU info]
```

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


### Docker

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


### WebAssembly

```sh
# build WASM target
make build-wasm

# build Web App package
make build-web

# run Web App server
make serve-app

# run Web App browser
# (open a Chrome window without 'chrome' with a second Dev Tools window)
# (assumes NVIDIA Discrete GPU)
make open-app
```


## Book of Dev

[README](./dev-book/README.md)
