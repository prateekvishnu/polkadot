#!/usr/bin/env bash

set -e

echo "*** Initializing WASM build environment"

if [ -z $CI_PROJECT_NAME ] ; then
   ${HOME}/.cargo/bin/rustup update nightly
   ${HOME}/.cargo/bin/rustup update stable
fi

${HOME}/.cargo/bin/rustup target add wasm32-unknown-unknown --toolchain nightly

# Install wasm-gc. It's useful for stripping slimming down wasm binaries.
command -v wasm-gc || \
	${HOME}/.cargo/bin/cargo +nightly install --git https://github.com/alexcrichton/wasm-gc --force
