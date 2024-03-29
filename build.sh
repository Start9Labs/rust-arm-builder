#!/bin/bash
set -e

echo 'Building Container'
docker build . -t start9/rust-arm-cross:aarch64
cat << 'EOF' | sudo tee /usr/local/bin/rust-arm64-builder
#!/bin/bash
docker run --rm -it -v "$HOME/.cargo/registry":/root/.cargo/registry -v $(pwd):/home/rust/src start9/rust-arm-cross:aarch64 $@
EOF
sudo chmod +x /usr/local/bin/rust-arm64-builder
