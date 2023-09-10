# Willem Mirkovich .config

## Requirements

- [brew installer](https://brew.sh/): Available for Mac/Linux
- [alacritty terminal emulator](https://alacritty.org/): `brew install alacritty`
- [neovim editor](https://neovim.io/): `brew install neovim`
- [node/npm](TODO:): `brew install node`
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/wiki#welcome-to-oh-my-zsh)
- [font-hack-nerd](https://www.nerdfonts.com/)
    - `brew tap homebrew/cask-fonts`
    - `brew install --cask font-hack-nerd-font`
- [starship](https://starship.rs/): `brew install starship`
- [tmux](https://github.com/tmux/tmux): `brew install tmux`
- [ripgrep](https://github.com/BurntSushi/ripgrep): `brew install ripgrep`
- [lazygit](TODO:): `brew install lazygit`
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm): `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## Nice to have

- [btop](https://github.com/aristocratos/btop): `brew install btop`

## Setup

1. Make sure zsh is default shell: `echo $SHELL`
2. Add following lines to your `.zshenv` file:
```
# NOTE: required for .config setup
ZDOTDIR=~/.config/zsh

# NOTE: below, specific to this machine
```
