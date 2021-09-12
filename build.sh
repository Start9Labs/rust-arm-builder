#!/bin/bash
set -e

echo 'Building Container'
docker build . -t start9/rust-arm-cross:aarch64
echo << EOF
#!/bin/bash
docker run --rm -it -v "$HOME/.cargo/registry":/root/.cargo/registry -v $(pwd):/home/rust/src start9/rust-arm-cross:aarch64 $@" > /usr/local/bin/rust-arm64-builder
EOF
chmod +x /usr/local/bin/rust-arm64-builder
