FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        curl \
        wget \
        tar \
        gcc-arm-linux-gnueabihf \
        openssl \
        libssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp && \
    cd /tmp && \
    wget https://www.openssl.org/source/openssl-1.1.1f.tar.gz && \
    tar xzf openssl-1.1.1f.tar.gz && \
    cd openssl-1.1.1f && \
    MACHINE=armv7 ARCH=arm CC=arm-linux-gnueabihf-gcc ./config shared && \
    MACHINE=armv7 ARCH=arm CC=arm-linux-gnueabihf-gcc make

ENV ARMV7_UNKNOWN_LINUX_GNUEABIHF_OPENSSL_LIB_DIR=/tmp/openssl-1.1.1f
ENV ARMV7_UNKNOWN_LINUX_GNUEABIHF_OPENSSL_INCLUDE_DIR=/tmp/openssl-1.1.1f/include

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN ~/.cargo/bin/rustup target add armv7-unknown-linux-gnueabihf
RUN ~/.cargo/bin/rustup install beta
RUN ~/.cargo/bin/rustup install nightly
RUN ~/.cargo/bin/rustup default stable

ENV PATH=/root/.cargo/bin:/usr/local/musl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV TARGET_CC=arm-linux-gnueabihf-gcc
ENV TARGET_CXX=arm-linux-gnueabihf-g++

ADD .cargo_config /root/.cargo/config

RUN mkdir -p /home/rust/libs /home/rust/src

WORKDIR /home/rust/src
