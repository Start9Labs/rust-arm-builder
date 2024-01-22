FROM rust:1.75.0

RUN dpkg --add-architecture arm64 && \
    dpkg --add-architecture amd64 && \
    apt-get update && \
    apt-get install -y \
        gcc-multilib \
        g++-multilib \
        libavahi-client-dev \
        libclang-dev && \
    (test "$(uname -m)" = "x86_64" || \
        apt-get install -y \
            libc6-dev-amd64-cross \
            gcc-x86-64-linux-gnu \
            g++-x86-64-linux-gnu \
            crossbuild-essential-amd64 \
            libavahi-client-dev:amd64 \
    ) && \
    (test "$(uname -m)" = "aarch64" || \
        apt-get install -y \
            libc6-dev-arm64-cross \
            gcc-aarch64-linux-gnu \
            g++-aarch64-linux-gnu \
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
