#!/usr/bin/env bash
# Build Release Assets v0.0.1
set -eu

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
smartrobot-bevy-devel:ubuntu-amd64 \
cargo build \
--profile release-lto \
--target x86_64-unknown-linux-gnu \
--features log-max,bevy/wayland

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
smartrobot-bevy-devel:debian-arm64 \
cargo build \
--profile release-lto \
--target aarch64-unknown-linux-gnu \
--features log-max,bevy/wayland

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

wasm-bindgen \
--out-name smartrobot_bevy \
--out-dir smartrobot-bevy-web/ \
--target web \
target/wasm32-unknown-unknown/wasm-release/smartrobot-bevy.wasm

zip -mr smartrobot-bevy-web.zip smartrobot-bevy-web/

mv smartrobot-bevy-web.zip dist/v0.0.1/



# APK release

. android-env.sh

rm -rf android/app/src/main/jniLibs/

cargo ndk \
-t arm64-v8a \
-t x86_64 \
-o android/app/src/main/jniLibs \
build \
--lib \
--profile mobile-release \
--features log-max

cd android/

./gradlew --warning-mode all clean build

cd ..

cp android/app/build/outputs/apk/debug/app-debug.apk \
dist/v0.0.1/smartrobot-bevy.apk



# Release Assets

ls -alh dist/v0.0.1/
