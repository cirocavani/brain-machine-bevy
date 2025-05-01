SHELL = /bin/bash


# Development

.PHONY: test
test:
	cargo test --all-targets --all-features

.PHONY: lint
lint:
	cargo clippy --all-targets --all-features -- -D warnings

.PHONY: format
format:
	cargo fmt --all -- --emit files

.PHONY: build
build: ARGS=--all-features
build:
	cargo build $(ARGS)

.PHONY: clean
clean:
	cargo clean


# Docker (local)

.PHONY: docker-build-ubuntu-amd64
docker-build-ubuntu-amd64:
	docker build \
	--platform linux/amd64 \
	--build-arg USER_ID=`id -u` \
	--build-arg GROUP_ID=`id -g` \
	-t smartrobot-bevy-devel:ubuntu-amd64 \
	-f docker/ubuntu/Dockerfile \
	.

.PHONY: docker-run-ubuntu-amd64
docker-run-ubuntu-amd64:
	docker run \
	--rm \
	-it \
	--platform linux/amd64 \
	-e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
	-e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v /etc/machine-id:/etc/machine-id:ro \
	-e CARGO_TARGET_DIR=/home/user/project/target/x86_64-unknown-linux-gnu \
	-v ${PWD}:/home/user/project \
	-v ${HOME}/.cargo/registry:/home/user/.cargo/registry \
	-v ${HOME}/.cargo/git:/home/user/.cargo/git \
	smartrobot-bevy-devel:ubuntu-amd64 \
	cargo run --features bevy/wayland

.PHONY: docker-run-ubuntu-amd64-nvidia
docker-run-ubuntu-amd64-nvidia:
	docker run \
	--rm \
	-it \
	--platform linux/amd64 \
	--runtime nvidia \
	--gpus all \
	--device /dev/dri \
	--group-add $(shell getent group video | cut -d ':' -f 3) \
	--group-add $(shell getent group render | cut -d ':' -f 3) \
	-e NVIDIA_DRIVER_CAPABILITIES=all \
	-e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
	-e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v /etc/machine-id:/etc/machine-id:ro \
	-e CARGO_TARGET_DIR=/home/user/project/target/x86_64-unknown-linux-gnu \
	-v ${PWD}:/home/user/project \
	-v ${HOME}/.cargo/registry:/home/user/.cargo/registry \
	-v ${HOME}/.cargo/git:/home/user/.cargo/git \
	smartrobot-bevy-devel:ubuntu-amd64 \
	cargo run --features bevy/wayland


.PHONY: docker-ubuntu-amd64
docker-ubuntu-amd64: docker-build-ubuntu-amd64 docker-run-ubuntu-amd64

.PHONY: docker-ubuntu-amd64-nvidia
docker-ubuntu-amd64-nvidia: docker-build-ubuntu-amd64 docker-run-ubuntu-amd64-nvidia

.PHONY: docker-build-debian-arm64
docker-build-debian-arm64:
	docker build \
	--platform linux/arm64 \
	--build-arg USER_ID=`id -u` \
	--build-arg GROUP_ID=`id -g` \
	-t smartrobot-bevy-devel:debian-arm64 \
	-f docker/debian/Dockerfile \
	.

.PHONY: docker-run-debian-arm64
docker-run-debian-arm64:
	docker run \
	--rm \
	-it \
	--platform linux/arm64 \
	-e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
	-e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v /etc/machine-id:/etc/machine-id:ro \
	-e CARGO_TARGET_DIR=/home/user/project/target/aarch64-unknown-linux-gnu \
	-v ${PWD}:/home/user/project \
	-v ${HOME}/.cargo/registry:/home/user/.cargo/registry \
	-v ${HOME}/.cargo/git:/home/user/.cargo/git \
	smartrobot-bevy-devel:debian-arm64 \
	cargo run --features bevy/wayland

.PHONY: docker-debian-arm64
docker-debian-arm64: docker-build-debian-arm64 docker-run-debian-arm64


# WebAssembly

.PHONY: build-wasm
build-wasm:
	cargo build \
	--profile wasm-release \
	--target wasm32-unknown-unknown \
	--no-default-features \
	--features log-max

.PHONY: build-web
build-web: build-wasm
	rm -f web-app/smartrobot_bevy*;
	wasm-bindgen \
	--out-name smartrobot_bevy \
	--out-dir web-app \
	--target web \
	target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

.PHONY: serve-app
serve-app:
	simple-http-server -i web-app/

.PHONY: open-app
open-app: export __NV_PRIME_RENDER_OFFLOAD=1
open-app: export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
open-app: export __GLX_VENDOR_LIBRARY_NAME=nvidia
open-app: export __VK_LAYER_NV_optimus=NVIDIA_only
open-app: export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
open-app: 
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
