#!/usr/bin/env bash

setup_macos() {
	# Xcode commande line tools
	if [[ ! $(xcode-select -p 1>/dev/null; echo $?) ]]; then
		echo "Install xcode commandline tools"
		xcode-select --install
	fi

	# Rosetta 2
	if ! (arch -arch x86_64 uname -m > /dev/null) ; then
		echo "Install Rosetta 2"
		softwareupdate --install-rosetta --agree-to-license
	fi

	# Homebrew
	if [[ $(command -v brew) == "" ]]; then
		echo "Install homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		git clone --recurse-submodules https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"
	fi

	if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	fi

	/opt/homebrew/bin/brew bundle install

	# Alacritty themes
	mkdir -p "${HOME}/.config/alacritty/themes"
	git clone https://github.com/alacritty/alacritty-theme "${HOME}/.config/alacritty/themes"

	# Sketchybar icons
	#curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.23/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

	# macOS settings
	#defaults write NSGlobalDomain _HIHideMenuBar -bool true
	#defaults write com.apple.dock autohide -bool true
	#defaults write com.apple.dock autohide-time-modifier -float 0.15
	#defaults write -g NSWindowShouldDragOnGesture YES
	#defaults write com.apple.dock expose-animation-duration -float 0.1
	#defaults write com.apple.dock missioncontrol-animation-duration -float 0.1
	#killall Dock
	#killall Finder

	# Setup dev env
	/opt/homebrew/bin/rustup-init -y
	/opt/homebrew/bin/opam init -y

	# Refresh zsh
	/opt/homebrew/bin/zsh
}

setup_linux() {
	echo "Not implemented"
}

if [[ "$(uname)" == "Darwin" ]]; then
	setup_macos 
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
	setup_linux
fi
