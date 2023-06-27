FROM rust:1.70.0

RUN dpkg --add-architecture arm64 && \
    dpkg --add-architecture amd64 && \
    apt-get update && \
    apt-get install -y \
        libavahi-client-dev \
        libclang-dev && \
    (test "$(uname -m)" = "x86_64" || \
        apt-get install -y \
            libc6-dev-amd64-cross \
            crossbuild-essential-amd64 \
            libavahi-client-dev:amd64 \
    ) && \
    (test "$(uname -m)" = "aarch64" || \
        apt-get install -y \
            libc6-dev-arm64-cross \
            crossbuild-essential-arm64 \
            libavahi-client-dev:arm64 \
    ) && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rustup target add x86_64-unknown-linux-gnu
RUN rustup target add aarch64-unknown-linux-gnu

ENV CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=/usr/bin/x86_64-linux-gnu-gcc
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=/usr/bin/aarch64-linux-gnu-gcc

RUN git config --global --add safe.directory /home/rust/src

RUN mkdir -p /home/rust/src

WORKDIR /home/rust/src
