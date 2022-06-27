FROM arm64v8/ubuntu:20.04 as libsrc

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
    libavahi-client-dev

FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
    build-essential \
    cmake \
    curl \
    wget \
    tar \
    git \
    gcc-*-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    openssl \
    libssl-dev \
    gcc-aarch64-linux-gnu \
    binutils-arm-linux-gnueabi \
    libc6-dev \
    # libc6-dev-i386 \
    clang \
    libclang-dev \
    libavahi-client-dev \
    upx && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN ~/.cargo/bin/rustup update
RUN ~/.cargo/bin/rustup install beta
RUN ~/.cargo/bin/rustup install nightly
RUN ~/.cargo/bin/rustup default stable
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-musl --toolchain stable
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-musl --toolchain beta
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-musl --toolchain nightly
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-gnu --toolchain stable
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-gnu --toolchain beta
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-gnu --toolchain nightly

ENV PATH=/root/.cargo/bin:/usr/local/musl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV TARGET_CC=aarch64-linux-gnu-gcc
ENV TARGET_CXX=aarch64-linux-gnu-g++

COPY --from=libsrc /usr/lib/aarch64-linux-gnu/libavahi-client.so.3.2.9 /usr/aarch64-linux-gnu/lib/libavahi-client.so.3.2.9
RUN ln -s /usr/aarch64-linux-gnu/lib/libavahi-client.so.3.2.9 /usr/aarch64-linux-gnu/lib/libavahi-client.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libavahi-client.so /usr/lib/gcc/aarch64-linux-gnu/9/libavahi-client.so
COPY --from=libsrc /usr/lib/aarch64-linux-gnu/libavahi-common.so.3.5.3 /usr/aarch64-linux-gnu/lib/libavahi-common.so.3.5.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libavahi-common.so.3.5.3 /usr/aarch64-linux-gnu/lib/libavahi-common.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libavahi-common.so /usr/lib/gcc/aarch64-linux-gnu/9/libavahi-common.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libdbus-1.so.3.19.11 /usr/aarch64-linux-gnu/lib/libdbus-1.so.3.19.11
RUN ln -s /usr/aarch64-linux-gnu/lib/libdbus-1.so.3.19.11 /usr/aarch64-linux-gnu/lib/libdbus-1.so.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libdbus-1.so.3 /usr/aarch64-linux-gnu/lib/libdbus-1.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libdbus-1.so.3 /usr/lib/gcc/aarch64-linux-gnu/9/libdbus-1.so.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libdbus-1.so /usr/lib/gcc/aarch64-linux-gnu/9/libdbus-1.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libsystemd.so.0.28.0 /usr/aarch64-linux-gnu/lib/libsystemd.so.0.28.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libsystemd.so.0.28.0 /usr/aarch64-linux-gnu/lib/libsystemd.so.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libsystemd.so.0 /usr/aarch64-linux-gnu/lib/libsystemd.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libsystemd.so.0 /usr/lib/gcc/aarch64-linux-gnu/9/libsystemd.so.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libsystemd.so /usr/lib/gcc/aarch64-linux-gnu/9/libsystemd.so
COPY --from=libsrc /lib/aarch64-linux-gnu/liblzma.so.5.2.4 /usr/aarch64-linux-gnu/lib/liblzma.so.5.2.4
RUN ln -s /usr/aarch64-linux-gnu/lib/liblzma.so.5.2.4 /usr/aarch64-linux-gnu/lib/liblzma.so.5
RUN ln -s /usr/aarch64-linux-gnu/lib/liblzma.so.5 /usr/aarch64-linux-gnu/lib/liblzma.so
RUN ln -s /usr/aarch64-linux-gnu/lib/liblzma.so.5 /usr/lib/gcc/aarch64-linux-gnu/9/liblzma.so.5
RUN ln -s /usr/aarch64-linux-gnu/lib/liblzma.so /usr/lib/gcc/aarch64-linux-gnu/9/liblzma.so
COPY --from=libsrc /usr/lib/aarch64-linux-gnu/liblz4.so.1.9.2 /usr/aarch64-linux-gnu/lib/liblz4.so.1.9.2
RUN ln -s /usr/aarch64-linux-gnu/lib/liblz4.so.1.9.2 /usr/aarch64-linux-gnu/lib/liblz4.so.1
RUN ln -s /usr/aarch64-linux-gnu/lib/liblz4.so.1 /usr/aarch64-linux-gnu/lib/liblz4.so
RUN ln -s /usr/aarch64-linux-gnu/lib/liblz4.so.1 /usr/lib/gcc/aarch64-linux-gnu/9/liblz4.so.1
RUN ln -s /usr/aarch64-linux-gnu/lib/liblz4.so /usr/lib/gcc/aarch64-linux-gnu/9/liblz4.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libgcrypt.so.20.2.5 /usr/aarch64-linux-gnu/lib/libgcrypt.so.20.2.5
RUN ln -s /usr/aarch64-linux-gnu/lib/libgcrypt.so.20.2.5 /usr/aarch64-linux-gnu/lib/libgcrypt.so.20
RUN ln -s /usr/aarch64-linux-gnu/lib/libgcrypt.so.20 /usr/aarch64-linux-gnu/lib/libgcrypt.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libgcrypt.so.20 /usr/lib/gcc/aarch64-linux-gnu/9/libgcrypt.so.20
RUN ln -s /usr/aarch64-linux-gnu/lib/libgcrypt.so /usr/lib/gcc/aarch64-linux-gnu/9/libgcrypt.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libgpg-error.so.0.28.0 /usr/aarch64-linux-gnu/lib/libgpg-error.so.0.28.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libgpg-error.so.0.28.0 /usr/aarch64-linux-gnu/lib/libgpg-error.so.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libgpg-error.so.0 /usr/aarch64-linux-gnu/lib/libgpg-error.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libgpg-error.so.0 /usr/lib/gcc/aarch64-linux-gnu/9/libgpg-error.so.0
RUN ln -s /usr/aarch64-linux-gnu/lib/libgpg-error.so /usr/lib/gcc/aarch64-linux-gnu/9/libgpg-error.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libselinux.so.1 /usr/aarch64-linux-gnu/lib/libselinux.so.1
RUN ln -s /usr/aarch64-linux-gnu/lib/libselinux.so.1 /usr/aarch64-linux-gnu/lib/libselinux.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libselinux.so.1 /usr/lib/gcc/aarch64-linux-gnu/9/libselinux.so.1
RUN ln -s /usr/aarch64-linux-gnu/lib/libselinux.so /usr/lib/gcc/aarch64-linux-gnu/9/libselinux.so
COPY --from=libsrc /lib/aarch64-linux-gnu/libpcre.so.3.13.3 /usr/aarch64-linux-gnu/lib/libpcre.so.3.13.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libpcre.so.3.13.3 /usr/aarch64-linux-gnu/lib/libpcre.so.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libpcre.so.3 /usr/aarch64-linux-gnu/lib/libpcre.so
RUN ln -s /usr/aarch64-linux-gnu/lib/libpcre.so.3 /usr/lib/gcc/aarch64-linux-gnu/9/libpcre.so.3
RUN ln -s /usr/aarch64-linux-gnu/lib/libpcre.so /usr/lib/gcc/aarch64-linux-gnu/9/libpcre.so

ADD .cargo_config /root/.cargo/config

RUN mkdir -p /home/rust/libs /home/rust/src
RUN git config --global --add safe.directory /home/rust/src

WORKDIR /home/rust/src
