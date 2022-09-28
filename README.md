# dotfiles

Some configuration files. [**Homebrew**](https://brew.sh/) is considered installed.

## Prerequisites

### zsh
Shell env is powered by [**ZIM**](https://github.com/zimfw/zimfw).
Quick install if missing:
```text
curl -fsSL --create-dirs -o ~/.zim/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
```
### Starship
Zsh is wrapped with [**Starship**](https://github.com/starship/starship). Fastest way to install is `brew install starhip` or alternatively:
```text
curl -sS https://starship.rs/install.sh | sh
```
By default `starhip` config is placed under `$HOME/.config/starship.toml`.

### vim
Vim uses [**Vim Plug**](https://github.com/junegunn/vim-plug) manager. Quick install if missing:
```text
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux
Tmux uses [**TPM**](https://github.com/tmux-plugins/tpm) manager. Quick install if missing:
```text
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
By default `tmux` config is placed under `$HOME/.config/tmux/tmux.conf`.

### direnv
Useful [**tool**](https://github.com/direnv/direnv) to manage env variables per project. Install with `brew install direnv` or:
```text
curl -sfL https://direnv.net/install.sh | bash
```
Configuration file should be placed here `$HOME/.config/direnv/direnv.toml`