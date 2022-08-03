# needed because it contains glibc 2.31, same as the current embassy-os raspios base image
FROM rust:slim-bullseye

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
    build-essential \
    cmake \
    curl \
    wget \
    tar \
    git \
    gcc-aarch64-linux-gnu \
    openssl \
    libssl-dev \
    gcc-aarch64-linux-gnu \
    binutils-arm-linux-gnueabi \
    libc6-dev \
    clang \
    libclang-dev \
    libavahi-client-dev \
    upx && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD .cargo_config /root/.cargo/config

RUN mkdir -p /home/rust/libs /home/rust/src
RUN git config --global --add safe.directory /home/rust/src

WORKDIR /home/rust/src
