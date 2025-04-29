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


# Local deploy

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

.PHONY: docker-ubuntu-amd64
docker-ubuntu-amd64: docker-build-ubuntu-amd64 docker-run-ubuntu-amd64

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
