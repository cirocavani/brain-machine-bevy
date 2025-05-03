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
	cargo run --features dev,bevy/wayland

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
	cargo run --features dev,bevy/wayland


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
	cargo run --features dev,bevy/wayland

.PHONY: docker-debian-arm64
docker-debian-arm64: docker-build-debian-arm64 docker-run-debian-arm64


# WebAssembly

.PHONY: build-wasm
build-wasm:
	cargo build \
	--profile wasm-release \
	--target wasm32-unknown-unknown \
	--features log-max

.PHONY: build-web
build-web: build-wasm
	rm -f web/smartrobot_bevy*;
	wasm-bindgen \
	--out-name smartrobot_bevy \
	--out-dir web/ \
	--target web \
	target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

.PHONY: serve-web
serve-web:
	simple-http-server -i web/

.PHONY: open-web
open-web: export __NV_PRIME_RENDER_OFFLOAD=1
open-web: export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
open-web: export __GLX_VENDOR_LIBRARY_NAME=nvidia
open-web: export __VK_LAYER_NV_optimus=NVIDIA_only
open-web: export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
open-web: 
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


# Android

.PHONY: build-android-lib
build-android-lib:
	. android-env.sh && \
	rm -rf android/app/src/main/jniLibs/ && \
	cargo ndk \
	-t arm64-v8a \
	-t x86_64 \
	-o android/app/src/main/jniLibs \
	build \
	--lib \
	--profile mobile-release \
	--features log-max

.PHONY: build-android-apk
build-android-apk:
	. android-env.sh && \
	cd android/ && \
	./gradlew --warning-mode all clean build

.PHONY: install-apk-emulator
install-apk-emulator:
	. android-env.sh && \
	adb -e install android/app/build/outputs/apk/debug/app-debug.apk

.PHONY: install-apk-device
install-apk-device:
	. android-env.sh && \
	adb -d install android/app/build/outputs/apk/debug/app-debug.apk

.PHONY: open-android-emulator
open-android-emulator: export __NV_PRIME_RENDER_OFFLOAD=1
open-android-emulator: export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
open-android-emulator: export __GLX_VENDOR_LIBRARY_NAME=nvidia
open-android-emulator: export __VK_LAYER_NV_optimus=NVIDIA_only
open-android-emulator: export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
open-android-emulator:
	. android-env.sh && \
	emulator -avd Pixel_9_Pro_API_35 -netdelay none -netspeed full

.PHONY: android-device
android-device: build-android-lib build-android-apk install-apk-device

.PHONY: android-emulator
android-emulator: build-android-lib build-android-apk install-apk-emulator
