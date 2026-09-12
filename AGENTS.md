# Repository guidance

- Active configuration is declarative Nix under `nix/`; update it rather than legacy copies.
- `apps/` stores backup themes/configuration only. It is not deployed or referenced by the Nix setup.
- Neovim plugins and Tree-sitter parsers are declared in `nix/home-manager/programs/neovim.nix`; do not use vim-plug or `:PlugInstall`.
- Tmux is the exception: its active configuration is the static `nix/home-manager/.config/tmux/tmux.conf` file, deployed by Home Manager.
- Do not expose or commit secrets or personal data (including passwords, tokens, private keys, email addresses, phone numbers, or home addresses). Machine usernames are allowed.
