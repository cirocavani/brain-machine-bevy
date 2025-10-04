#!/usr/bin/env bash
# Build Release Assets v0.0.1
set -eu

rm -rf dist/v0.0.1/

mkdir -p dist/v0.0.1/



echo
echo "Linux x86_64 binary release"
echo

docker run \
--rm \
-it \
--platform linux/amd64 \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
brain-machine-bevy-ubuntu:latest \
cargo build \
--profile release-lto \
--target x86_64-unknown-linux-gnu \
--features log-max,wayland

cp target/x86_64-unknown-linux-gnu/release-lto/brain-machine-bevy \
dist/v0.0.1/brain-machine-bevy-linux-x86_64



echo
echo "Linux aarch64 binary release"
echo

docker run \
--rm \
-it \
--platform linux/arm64 \
-v $PWD:/home/user/project \
-v $HOME/.cargo/registry:/home/user/.cargo/registry \
-v $HOME/.cargo/git:/home/user/.cargo/git \
brain-machine-bevy-debian:latest \
cargo build \
--profile release-lto \
--target aarch64-unknown-linux-gnu \
--features log-max,wayland

cp target/aarch64-unknown-linux-gnu/release-lto/brain-machine-bevy \
dist/v0.0.1/brain-machine-bevy-linux-aarch64



echo
echo "WASM package (site)"
echo

rm -rf brain-machine-bevy-web/

mkdir -p brain-machine-bevy-web/

cp web/index.html brain-machine-bevy-web/

cargo build \
--profile wasm-release \
--target wasm32-unknown-unknown \
--features log-max

wasm-bindgen \
--out-name brain_machine_bevy \
--out-dir brain-machine-bevy-web/ \
--target web \
target/wasm32-unknown-unknown/wasm-release/brain-machine-bevy.wasm

zip -mr brain-machine-bevy-web.zip brain-machine-bevy-web/

mv brain-machine-bevy-web.zip dist/v0.0.1/



echo
echo "APK release"
echo

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
dist/v0.0.1/brain-machine-bevy.apk



echo
echo "Release Assets"
echo

ls -alh dist/v0.0.1/
