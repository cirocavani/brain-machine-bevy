#!/usr/bin/env bash
# WebAssembly Setup

set -eu


echo
echo "Rust WebAssembly Support"
echo

rustup target add wasm32-unknown-unknown

cargo binstall -y wasm-bindgen-cli


echo
echo "HTTP Server"
echo

cargo binstall -y simple-http-server


echo
echo "Google Chrome"
echo

curl --proto '=https' --tlsv1.2 -sSfLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt install -f


echo
echo "WebAssembly Setup done."
