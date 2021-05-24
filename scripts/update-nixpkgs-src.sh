#! /usr/bin/env nix-shell
#! nix-shell -i bash -p git

set -euo pipefail

info() { echo "[INFO] $@"; }

branch="nixpkgs-unstable"
if [[ -z "${1:-}" ]]; then
    commit="$(git ls-remote git://github.com/NixOS/nixpkgs "refs/heads/${branch}" | cut -d$'\t' -f1)"
else
    commit="$1"
fi

info "Using commit '${commit}'."

info "Prefetching and computing SHA256..."
nixpkgs_url="https://github.com/nixos/nixpkgs/archive/${commit}.tar.gz"
prefetch_sha256="$(nix-prefetch-url --unpack "${nixpkgs_url}")"

info "Generating new 'nixpkgs-src.nix'..."
cat <<EOF > nixpkgs-src.nix
{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "$nixpkgs_url";
  sha256 = "${prefetch_sha256}";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
EOF

info "Done!"
