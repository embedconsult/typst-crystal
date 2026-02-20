#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/bin"

mkdir -p "${BIN_DIR}"

cargo build --release --package typst-cli
cp "${ROOT_DIR}/target/release/typst" "${BIN_DIR}/typst-rust"

crystal build "${ROOT_DIR}/src/typst.cr" --release -o "${BIN_DIR}/typst"
