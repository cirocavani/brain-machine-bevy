#!/usr/bin/env bash
# Project Setup
# Ubuntu 25.04 Plucky (NVIDIA GPU)

set -eu


echo
echo "Install basic utilities"
echo

sudo apt update

sudo apt install -y \
--no-install-recommends \
ca-certificates \
curl \
gpg \
unzip \
mesa-vulkan-drivers \
mesa-utils \
vulkan-tools


echo
echo "Install Rust Toolchain"
echo

curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | \
sh -s -- --default-toolchain stable -y

. "$HOME/.cargo/env"


echo
echo "Cargo Binary Install"
echo

# https://github.com/cargo-bins/cargo-binstall

curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | \
bash


echo
echo "Install Compiler (clang / lld)"
echo

sudo apt install -y \
--no-install-recommends \
clang \
lld

# Debina 12
#
# sudo apt install -y --no-install-recommends clang-19 lld-19
# 
# update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100
# update-alternatives --install /usr/bin/lld lld /usr/bin/lld-19 100
# update-alternatives --install /usr/bin/cc cc /usr/bin/clang-19 100


echo
echo "Install Build Dependencies"
echo

# https://github.com/bevyengine/bevy/blob/main/docs/linux_dependencies.md#ubuntu

sudo apt install -y \
--no-install-recommends \
pkg-config \
libasound2-dev \
libudev-dev \
libx11-dev \
libxkbcommon-x11-0 \
libwayland-dev \
libxkbcommon-dev


echo
echo "Install Docker Engine"
echo

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


echo
echo "Install QEMU (Docker uses to run ARM64 on AMD64)"
echo

sudo apt install -y \
--no-install-recommends \
qemu-user-static \
binfmt-support


echo
echo "Install NVIDIA Container Toolkit"
echo

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg --yes

echo 'deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /' | \
sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

sudo apt update

sudo apt install -y --no-install-recommends nvidia-driver-570
sudo apt install -y --no-install-recommends nvidia-container-toolkit


echo
echo "Setup done."
