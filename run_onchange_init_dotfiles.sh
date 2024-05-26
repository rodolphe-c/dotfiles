#!/usr/bin/env bash

install_xcode() {
	if [[ ! $(xcode-select -p 1>/dev/null; echo $?) ]]; then
		echo "Install xcode commandline tools"
		xcode-select --install
	fi
}

install_rosetta() {
	if ! (arch -arch x86_64 uname -m > /dev/null) ; then
		echo "Install Rosetta 2"
		softwareupdate --install-rosetta --agree-to-license
	fi
}

install_brew() {
	if [[ $(command -v brew) == "" ]]; then
		echo "Install homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	if ! (arch -arch x86_64 uname -m > /dev/null) ; then
		BREW_PREFIX="/opt/homebrew/bin"
	else
		BREW_PREFIX="/usr/local/bin"
	fi

	echo "Install brew bundle"
	"${BREW_PREFIX}/brew" bundle install
	"${BREW_PREFIX}/rustup-init" -y
	"${BREW_PREFIX}/opam" init -y
}

install_ohmyzsh() {
	echo "Install ohmyzsh"
	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		git clone --recurse-submodules https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"
	fi

	if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	fi
}

install_alacritty_themes() {
	echo "Install alacritty themes"
	if [ ! -d "${HOME}/.config/alacritty/themes" ]; then
		mkdir -p "${HOME}/.config/alacritty/themes"
		git clone https://github.com/alacritty/alacritty-theme "${HOME}/.config/alacritty/themes"
	fi
}

install_deps() {
	echo "Install dependencies"
	if [[ "$(uname)" == "Darwin" ]]; then
		install_xcode
		install_rosetta
		install_brew
	elif [[ $(command -v yay) != "" ]]; then
		yay -S --needed --noconfirm base-devel \
			alacritty \
			tmux \
			fd \
			zsh \
			ripgrep \
			git \
			neofetch \
			neovim \
			fzf \
			doxygen \
			ninja \
			cmake \
			clang \
			rustup \
			opam \
			btop

	elif [[ $(command -v dnf) != "" ]]; then
		echo "TODO"
	elif [[ $(command -v apt) != "" ]]; then
		echo "TODO"
	fi

	rm "${HOME}/Brewfile"
}

setup() {
	# Install deps
	install_deps

	# ohmyzsh
	install_ohmyzsh

	# Alacritty themes
	install_alacritty_themes
}

setup
