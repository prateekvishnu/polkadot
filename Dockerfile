# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang curl build-essential git libclang-dev pkg-config libssl-dev
RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN ${HOME}/.cargo/bin/rustup default nightly
RUN ${HOME}/.cargo/bin/cargo install -f cargo-fuzz

## Add source code to the build stage.
ADD . /polkadot
WORKDIR /polkadot

RUN ./scripts/init.sh 
RUN ${HOME}/.cargo/bin/cargo build --release

# Package Stage
FROM ubuntu:20.04

COPY --from=builder polkadot/target/release/polkadot /




