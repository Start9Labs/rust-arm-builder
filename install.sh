#!/bin/bash

echo 'Building Container'
docker build . -t start9/rust-arm-cross
ALIAS='rust-arm-builder=docker run --rm -it -v "$HOME/.cargo/registry":/root/.cargo/registry -v "$(pwd)":/home/rust/src start9/rust-arm-cross:latest'
alias "$ALIAS"

echo 'To have the "rust-arm-builder" command available beyond this session, add the following line to your .bashrc or .bash_profile:'
echo "alias '$ALIAS'"