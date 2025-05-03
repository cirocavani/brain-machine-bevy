#!/usr/bin/env bash
# Android Setup

set -eu


echo
echo "Install Rust Android Support"
echo

rustup target add \
aarch64-linux-android \
x86_64-linux-android

cargo binstall -y cargo-ndk


echo
echo "Install Android SDK / NDK"
echo

sudo apt install -y \
--no-install-recommends \
openjdk-17-jdk-headless \
openjdk-17-jre-headless \
java-common

sudo update-java-alternatives --set java-1.17.0-openjdk-amd64


export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export NDK_HOME="$ANDROID_HOME/ndk/27.0.12077973"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

mkdir -p $ANDROID_HOME


curl --proto '=https' --tlsv1.2 -sSfLO https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip

unzip commandlinetools-linux-13114758_latest.zip


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

rm -rf cmdline-tools/ commandlinetools-linux-13114758_latest.zip


avdmanager create avd \
--name Pixel_9_Pro_API_35 \
--device pixel_9_pro \
--package 'system-images;android-35;default;x86_64'


echo
echo "Android Setup done."
