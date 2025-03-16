# Willem Mirkovich .config

## Requirements

- [brew installer](https://brew.sh/): Available for Mac/Linux
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/wiki#welcome-to-oh-my-zsh)
- [brew packages]: 
    - [alacritty terminal emulator](https://alacritty.org/)
    - [neovim editor](https://neovim.io/)
    - [node/npm](TODO:)
    - [font-hack-nerd](https://www.nerdfonts.com/)
    - [starship](https://starship.rs/)
    - [tmux](https://github.com/tmux/tmux)
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [lazygit](TODO:)
    - [btop](https://github.com/aristocratos/btop)
    - [luarocks](https://luarocks.org/)
    ```sh
    brew instal alacritty neovim node font-hack-nerd-font \
    starship tmux ripgrep lazygit btop luarocks
    ```
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm): `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

## Setup

1. Make sure zsh is default shell: `echo $SHELL`
2. Add following lines to your `.zshenv` file:
```
# NOTE: required for .config setup
ZDOTDIR=~/.config/zsh

# NOTE: below, specific to this machine
```
3. Create `venv` for neovim to use
```sh
brew insatll pyenv
# https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
src # reload shell with new path
pyenv install 3.11.5
pyenv global 3.11.5
which python # verify looking at right place
python -m venv ~/.venv/nvim
venv_activate nvim
pip install --upgrade pip
pip install jupyter ipykernel nbclassic pynvim neovim
```
