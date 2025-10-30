#!/bin/bash

# NVide Installation Script
# This script installs the NVide configuration for Neovim

set -e  # Exit on any error

# Define paths
NVIM_CONFIG_DIR="$HOME/.config/nvim"
LUA_DIR="$NVIM_CONFIG_DIR/lua"
INIT_FILE="$NVIM_CONFIG_DIR/init.lua"
NVIDE_FILE="$LUA_DIR/nvide.lua"

# Create directories if they don't exist
mkdir -p "$LUA_DIR"

# Download nvide.lua to the correct location
curl -fsSL https://raw.githubusercontent.com/hashylog/nvide/main/nvide.lua -o "$NVIDE_FILE"

# Check if init.lua exists, create if not
if [ ! -f "$INIT_FILE" ]; then
    touch "$INIT_FILE"
fi

# Check if require('nvide') is already in init.lua
if ! grep -q "require('nvide')" "$INIT_FILE"; then
    echo "" >> "$INIT_FILE"
    echo "-- NVide" >> "$INIT_FILE"
    echo "require('nvide')" >> "$INIT_FILE"
    echo "Added require('nvide') to $INIT_FILE"
else
    echo "require('nvide') already exists in $INIT_FILE"
fi

echo "NVide installation completed successfully!"
echo "Restart NeoVim to apply the configuration."
