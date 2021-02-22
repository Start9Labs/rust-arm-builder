FROM raspbian/stretch as libsrc

RUN apt-get update && \
    apt-get install -y \
    libavahi-client-dev

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    curl \
    wget \
    tar \
    git \
    gcc-7-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabihf \
    openssl \
    libssl-dev \
    gcc-arm-linux-gnueabihf \
    binutils-arm-linux-gnueabi \
    libc6-dev \
    libc6-dev-i386 \
    clang \
    libclang-dev \
    libavahi-client-dev \
    upx && \
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

RUN ~/.cargo/bin/rustup install beta
RUN ~/.cargo/bin/rustup install nightly
RUN ~/.cargo/bin/rustup default stable
RUN ~/.cargo/bin/rustup target add armv7-unknown-linux-gnueabihf --toolchain stable
RUN ~/.cargo/bin/rustup target add armv7-unknown-linux-gnueabihf --toolchain beta
RUN ~/.cargo/bin/rustup target add armv7-unknown-linux-gnueabihf --toolchain nightly

ENV PATH=/root/.cargo/bin:/usr/local/musl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV TARGET_CC=arm-linux-gnueabihf-gcc
ENV TARGET_CXX=arm-linux-gnueabihf-g++

COPY --from=libsrc /usr/lib/arm-linux-gnueabihf/libavahi-client.so.3.2.9 /usr/arm-linux-gnueabihf/lib/libavahi-client.so.3.2.9
RUN ln -s /usr/arm-linux-gnueabihf/lib/libavahi-client.so.3.2.9 /usr/arm-linux-gnueabihf/lib/libavahi-client.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libavahi-client.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libavahi-client.so
COPY --from=libsrc /usr/lib/arm-linux-gnueabihf/libavahi-common.so.3.5.3 /usr/arm-linux-gnueabihf/lib/libavahi-common.so.3.5.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libavahi-common.so.3.5.3 /usr/arm-linux-gnueabihf/lib/libavahi-common.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libavahi-common.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libavahi-common.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libdbus-1.so.3.14.18 /usr/arm-linux-gnueabihf/lib/libdbus-1.so.3.14.18
RUN ln -s /usr/arm-linux-gnueabihf/lib/libdbus-1.so.3.14.18 /usr/arm-linux-gnueabihf/lib/libdbus-1.so.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libdbus-1.so.3 /usr/arm-linux-gnueabihf/lib/libdbus-1.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libdbus-1.so.3 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libdbus-1.so.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libdbus-1.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libdbus-1.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libsystemd.so.0.17.0 /usr/arm-linux-gnueabihf/lib/libsystemd.so.0.17.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libsystemd.so.0.17.0 /usr/arm-linux-gnueabihf/lib/libsystemd.so.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libsystemd.so.0 /usr/arm-linux-gnueabihf/lib/libsystemd.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libsystemd.so.0 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libsystemd.so.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libsystemd.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libsystemd.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/liblzma.so.5.2.2 /usr/arm-linux-gnueabihf/lib/liblzma.so.5.2.2
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblzma.so.5.2.2 /usr/arm-linux-gnueabihf/lib/liblzma.so.5
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblzma.so.5 /usr/arm-linux-gnueabihf/lib/liblzma.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblzma.so.5 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/liblzma.so.5
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblzma.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/liblzma.so
COPY --from=libsrc /usr/lib/arm-linux-gnueabihf/liblz4.so.1.7.1 /usr/arm-linux-gnueabihf/lib/liblz4.so.1.7.1
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblz4.so.1.7.1 /usr/arm-linux-gnueabihf/lib/liblz4.so.1
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblz4.so.1 /usr/arm-linux-gnueabihf/lib/liblz4.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblz4.so.1 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/liblz4.so.1
RUN ln -s /usr/arm-linux-gnueabihf/lib/liblz4.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/liblz4.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libgcrypt.so.20.1.6 /usr/arm-linux-gnueabihf/lib/libgcrypt.so.20.1.6
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgcrypt.so.20.1.6 /usr/arm-linux-gnueabihf/lib/libgcrypt.so.20
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgcrypt.so.20 /usr/arm-linux-gnueabihf/lib/libgcrypt.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgcrypt.so.20 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libgcrypt.so.20
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgcrypt.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libgcrypt.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libgpg-error.so.0.21.0 /usr/arm-linux-gnueabihf/lib/libgpg-error.so.0.21.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgpg-error.so.0.21.0 /usr/arm-linux-gnueabihf/lib/libgpg-error.so.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgpg-error.so.0 /usr/arm-linux-gnueabihf/lib/libgpg-error.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgpg-error.so.0 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libgpg-error.so.0
RUN ln -s /usr/arm-linux-gnueabihf/lib/libgpg-error.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libgpg-error.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libselinux.so.1 /usr/arm-linux-gnueabihf/lib/libselinux.so.1
RUN ln -s /usr/arm-linux-gnueabihf/lib/libselinux.so.1 /usr/arm-linux-gnueabihf/lib/libselinux.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libselinux.so.1 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libselinux.so.1
RUN ln -s /usr/arm-linux-gnueabihf/lib/libselinux.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libselinux.so
COPY --from=libsrc /lib/arm-linux-gnueabihf/libpcre.so.3.13.3 /usr/arm-linux-gnueabihf/lib/libpcre.so.3.13.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libpcre.so.3.13.3 /usr/arm-linux-gnueabihf/lib/libpcre.so.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libpcre.so.3 /usr/arm-linux-gnueabihf/lib/libpcre.so
RUN ln -s /usr/arm-linux-gnueabihf/lib/libpcre.so.3 /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libpcre.so.3
RUN ln -s /usr/arm-linux-gnueabihf/lib/libpcre.so /usr/lib/gcc-cross/arm-linux-gnueabihf/7/libpcre.so

ADD .cargo_config /root/.cargo/config

RUN mkdir -p /home/rust/libs /home/rust/src

WORKDIR /home/rust/src
