# Rust ARM64 Build Container

This is a docker container required for cross-compiling Rust to aarch64 during the EmbassyOS build process.

## Prerequisites
```
sudo docker run --rm --privileged linuxkit/binfmt:v0.8
```

## Installation
```
sudo ./build.sh
```

## Usage
```
rust-arm-builder cargo <command>
```
