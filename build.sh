#!/bin/bash

echo 'Building Container'
docker build . -t start9/rust-arm-cross
echo "#!/bin/bash
docker run --rm -it -v "$HOME/.cargo/registry":/root/.cargo/registry -v \$(pwd):/home/rust/src start9/rust-arm-cross:latest \$@" > /usr/local/bin/rust-arm-builder
chmod +x /usr/local/bin/rust-arm-builder
