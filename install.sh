#!/usr/bin/env zsh
# Link dotfiles into $HOME with GNU Stow. Safe to re-run after adding or
# removing files in a package.
#
# Extra arguments are passed to stow:
#   ./install.sh -n -v      dry run
#   ./install.sh --adopt    first run on a machine with existing configs
set -euo pipefail

cd "$(dirname "$0")"

common=(bin ghostty git gnupg nvim starship tmux zsh)
linux=(xdg emptty hypr waybar wofi)
darwin=()

if [[ $(uname) == "Darwin" ]]; then
  packages=($common $darwin)
else
  packages=($common $linux)
fi

# gpg-agent writes keys here, so stow must not turn it into a symlink
# pointing at the repo.
mkdir -p -m 700 "$HOME/.gnupg"

stow --target="$HOME" --restow "$@" $packages
