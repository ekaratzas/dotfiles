#!/bin/bash

sudo apt update

sudo apt install -y \
  # Archive & compression tools
  7zip zip unzip unrar-free p7zip tar \
  \
  # Media players & multimedia
  vlc mpv musescore \
  \
  # Development & build tools
  build-essential python3 git \
  \
  # Shell, terminal, and CLI productivity
  zsh fzf ranger bat silversearcher-ag command-not-found \
  zsh-autosuggestions zsh-syntax-highlighting stow \
  \
  # Networking & system utilities
  ethtool net-tools wget htop neofetch \
  \
  # Desktop & GUI utilities
  mousepad kolourpaint xfce4-appfinder rofi xsel \
  \
  # Package & app management
  flatpak qbittorrent \
  \
  # Editors
  vim

