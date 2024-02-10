#! /bin/bash

# install oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install fzf
yes | git clone https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

# install zsh-autocompletions
yes | git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

yes | sudo apt-get update
# yes | sudo apt-get dist-upgrade

# update tmux
yes | sudo apt-get install tmux
yes | sudo apt-get install vim=2:8.2.*

# vim plug
yes | curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# get node for COC
wget https://nodejs.org/dist/v20.9.0/node-v20.9.0-linux-x64.tar.xz 
tar -xvf node-v20.9.0-linux-x64.tar.xz
export PATH=$PATH:/users/ajain442/node-v20.9.0-linux-x64/bin/

# install rust
yes 1 | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# get basic python utils, update venv version as needed
yes | sudo apt-get install python3-pip
yes | pip install --upgrade virtualenv

# get clang
sudo apt-get install clang

# get silver searcher
sudo apt-get install silversearcher-ag

# remove existing/default setup files and bring in the latest
rm -f .zshrc .vimrc .tmux.conf
wget https://raw.githubusercontent.com/ajx42/dot-set-go/main/.zshrc || true
wget https://raw.githubusercontent.com/ajx42/dot-set-go/main/.tmux.conf || true
wget https://raw.githubusercontent.com/ajx42/dot-set-go/main/.vimrc || true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-coc)
      echo "Not using COC in vim"
      wget https://raw.githubusercontent.com/ajx42/dot-set-go/main/.vimrc-nococ || true
      mv .vimrc-nococ .vimrc
      shift
      ;;
    *)
      echo "Invalid Option: Ignoring"
      mv .vimrc-nococ .vimrc
      shift
      ;;
  esac
done
