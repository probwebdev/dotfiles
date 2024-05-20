# dotfiles

Quick and organised way to use/re-use environment setup.\
This setup relies on usage of [stow](https://www.gnu.org/software/stow/).

[**Homebrew**](https://brew.sh/) is considered optional and configuration should be sourced manually. On Fedora it's better to use built-in package manager instead.

## Pre-requisites

### Quick installation:

Fedora

```shell
# shell tools
dnf copr enable atim/starship
dnf install alacritty starship stow zoxide fzf fd-find git-delta tmux neovim direnv

# zimfw
curl -fsSL --create-dirs -o ~/.zim/zimfw.zsh --create-dirs \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

# proto
curl -fsSL https://moonrepo.dev/install/proto.sh | bash
proto completions > ~/.proto/_proto

# tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Shell tools

List of shell tools:

- [**alacritty**](https://github.com/alacritty/alacritty)
- [**starship**](https://github.com/starship/starship)
- [**zimfw**](https://github.com/zimfw/zimfw)
- [**proto**](https://moonrepo.dev/proto)
- [**zoxide**](https://github.com/ajeetdsouza/zoxide)
- [**fzf**](https://github.com/junegunn/fzf)
- [**fd**](https://github.com/sharkdp/fd)
- [**delta**](https://github.com/dandavison/delta)
- [**vim-plug**](https://github.com/junegunn/vim-plug)
- [**direnv**](https://github.com/direnv/direnv)

## Use dotfiles

After pre-requisites installed do this from your home directory:

```shell
git clone git@github.com:probwebdev/dotfiles.git .dotfiles
cd dotfiles
stow .
```

Look for existing files and either remove them or move to a backup folder. Alternatively run `stow --adopt .` to adopt existing configuration files.   
To stow new files run this from dotfiles `stow --restow .`
