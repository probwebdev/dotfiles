# dotfiles

Environment configuration files.   
[**Homebrew**](https://brew.sh/) is considered optional. On Fedora it's better to use built-in package manager instead.

## Prerequisites

### zsh
Shell env is powered by [**ZIM**](https://github.com/zimfw/zimfw).
Quick install if missing:
```text
curl -fsSL --create-dirs -o ~/.zim/zimfw.zsh --create-dirs \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
```

### Starship
Zsh is wrapped with [**Starship**](https://github.com/starship/starship). Fastest way to install:
```text
curl -sS https://starship.rs/install.sh | sh
```
By default `starhip` config is placed under `$HOME/.config/starship.toml`.

### Zoxide and fzf
Install additional tools for better shell navigation:
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

https://github.com/junegunn/fzf
### Proto
Install toolchain manager [**Proto**](https://moonrepo.dev/proto):
```text
curl -fsSL https://moonrepo.dev/install/proto.sh | bash
```
To generate completions use `proto completions > ~/.proto/_proto` if needed (already included in dotfiles).


### Vim and NeoVim
Vim/NeoVim uses [**Vim Plug**](https://github.com/junegunn/vim-plug) manager. Quick install if missing:
```text
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### tmux
Tmux uses [**TPM**](https://github.com/tmux-plugins/tpm) manager. Quick install if missing:
```text
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
By default `tmux` config is placed under `$HOME/.config/tmux/tmux.conf`.

### direnv
Useful [**tool**](https://github.com/direnv/direnv) to manage env variables per project. Quick Install:
```text
curl -sfL https://direnv.net/install.sh | bash
```
Configuration file should be placed here `$HOME/.config/direnv/direnv.toml`