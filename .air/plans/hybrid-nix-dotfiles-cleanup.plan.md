## 1. Goal

Make the existing Nix setup explicitly hybrid: retain native, file-based application configuration while using Home Manager for package installation, deployment, and platform integration—without re-enabling version-sensitive application modules.

## 2. Approach

Keep the current stable behavior: raw application config files are deployed through `home.file`, so Home Manager upgrades cannot silently translate their options into changed generated config. Remove the inactive alternative module definitions to make that decision unambiguous, and document an evaluation-first update workflow for both Linux and macOS. Defer replacement of the shell’s third-party bootstrappers to a separate reliability plan, because it changes the update ownership model rather than merely cleaning up configuration.

## 3. File Changes

- **Modify** [common.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/common.nix?type=file&root=%252F) — document the intended split between Nix-managed packages/deployment and native application configuration; retain the existing `home.file` mappings for bat, delta, Git, Neovim, tlrc, tmux, Starship, and Zsh support files.
- **Delete** [alacritty.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/alacritty.nix?type=file&root=%252F), [bat.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/bat.nix?type=file&root=%252F), [delta.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/delta.nix?type=file&root=%252F), [direnv.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/direnv.nix?type=file&root=%252F), [ghostty.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/ghostty.nix?type=file&root=%252F), [git.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/git.nix?type=file&root=%252F), [starship.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/starship.nix?type=file&root=%252F), and [tmux.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/tmux.nix?type=file&root=%252F) — remove unimported, duplicate configuration paths that could be mistaken for active settings. Keep [shell.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/shell.nix?type=file&root=%252F) and [gnome.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/programs/gnome.nix?type=file&root=%252F), which are imported and active.
- **Modify** [README.md](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/README.md?type=file&root=%252F) — add the configuration-boundary policy and safe flake-update procedure; remove wording that implies all settings are generated from Home Manager options.

## 4. Implementation Steps

### Task 1: Make ownership explicit

1. In [common.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/common.nix?type=file&root=%252F), replace generated template comments around `home.file` with a concise ownership note: Nix owns packages, fonts, garbage collection, and links; each application owns its native source config under the repository.
2. Keep the existing file links unchanged, including the Git, tmux, Starship, and Neovim files. This preserves the rendered configs currently in use across Linux and macOS.
3. Add an inline guardrail beside the sole import explaining that application-specific `programs/*` modules are intentionally not imported because option schemas change more often than the native config formats.

### Task 2: Remove inactive duplicate models

1. Delete the eight unimported application modules listed above after comparing each module’s effective settings to the corresponding native configuration file where one exists.
2. Do not delete or rewrite the native configs in [config](air-folder://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/.config?root=%252F), the Ghostty deployment entries in [dev.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/dev.nix?type=file&root=%252F), or active shell/GNOME modules.
3. Confirm [flake.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/home-manager/flake.nix?type=file&root=%252F) continues to load the common configuration for both Linux hosts, and [home-mbp14.nix](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/nix/darwin/home-mbp14.nix?type=file&root=%252F) continues to use it on macOS.

### Task 3: Add a safe update contract

1. In [README.md](air-file://6doe57fmhv04lr4l6l2p/home/probwebdev/.dotfiles/README.md?type=file&root=%252F), document the two-layer model and point maintainers to native config files for application changes.
2. Before each switch, document dry-run evaluation commands for Linux `t495`, Linux `homelab`, and macOS `mbp`; require inspecting the relevant lock-file diff after `nix flake update`.
3. State that flake-input updates and native configuration edits should be reviewed and committed separately, so a Home Manager schema failure or behavioral regression has a small, reversible diff.

## 5. Acceptance Criteria

- Both Linux Home Manager configurations still evaluate successfully without importing any removed application module.
- The macOS `mbp` configuration still evaluates successfully and retains the existing package/config deployment behavior.
- All deployed application configurations remain sourced from the checked-in native files; no generated bat, delta, Git, tmux, Starship, Ghostty, or Neovim configuration is introduced.
- There is no remaining unimported file under the Home Manager application-module directory.
- The README describes the hybrid ownership boundary and has one non-mutating preflight command for every declared host target.
- No Stow files or instructions are changed.

## 6. Verification Steps

1. From the Linux flake directory, run `nix flake check --no-build`, then dry-run builds for `homeConfigurations.t495.activationPackage` and `homeConfigurations.homelab.activationPackage`.
2. From the Darwin flake directory, run `nix flake check --no-build` and a dry-run build for `darwinConfigurations.mbp.system`.
3. On one Linux and the Mac host, run the normal switch command only after its dry-run succeeds; verify that Git, tmux, Starship, Neovim, Ghostty (Mac), and Zsh point to the checked-in native config files.
4. Start a new shell and verify existing aliases, completion setup, and private-config sourcing still work. Confirm no behavior changed merely from removing inactive modules.

## 7. Risks & Mitigations

- **Hidden dependence on a module assumed to be active:** confirm the import graph before deletion and evaluate all three host targets; the current shared import list contains only the shell module.
- **Future contributors reintroduce generated settings:** the ownership comment and README policy make the boundary explicit; review new `programs.<app>` declarations against the native config before merging.
- **Imperative shell bootstrap remains non-reproducible:** leave it untouched in this plan to avoid conflating concerns. Address it separately by moving downloads/updates out of login startup into explicit, version-pinned bootstrap commands.