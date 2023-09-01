#!/usr/bin/env bash

source "$HOME/.cargo/env"
source "$HOME/.config/bashrc/bashrc"
source "$HOME/.config/bashrc/gitssh"
source "$HOME/.config/bashrc/nvm"
source "$HOME/.config/bashrc/fzf"
source "$HOME/.config/bashrc/nvim"
source "$HOME/.config/bashrc/zellij"

eval "$(starship init bash)"
