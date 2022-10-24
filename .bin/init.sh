#!/bin/sh

# Check OS
if [ "$(uname)" != "Darwssin" ] ; then
  echo "Not macOS!"
  exit 1
fi

# Install xcode
# XcodeがないとHomebrewをインストールできない
xcode-select --install > /dev/null

# Install Homebrew
if [ ! -f /usr/local/bin/brew ]
 then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" > /dev/null
 else
  echo "Homebrew is already installed."
fi

