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

	if (arch -arch arm64 uname -m > /dev/null) ; then
		BREW_PREFIX="/opt/homebrew/bin"
	else
		BREW_PREFIX="/usr/local/bin"
	fi

	echo "Install brew bundle"
	"${BREW_PREFIX}/brew" bundle install
	"${BREW_PREFIX}/rustup-init" -y
}

install_themes() {
	echo "Install ohmyzsh"
	if [ ! -d "${HOME}/.config/yazi/flavors/tokyo-night.yazi" ]; then
		git clone https://github.com/BennyOe/tokyo-night.yazi.git "${HOME}/.config/yazi/flavors/tokyo-night.yazi"
	fi
}

install_deps() {
	echo "Install dependencies"
	if [[ "$(uname)" == "Darwin" ]]; then
		install_xcode
		install_rosetta
		install_brew
	else
		echo "Unsupported platform"
	fi

	rm "${HOME}/Brewfile"
}

setup() {
	# Install deps
	install_deps

	# themes
	install_themes
}

setup
