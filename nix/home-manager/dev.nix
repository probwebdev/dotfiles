{
  lib,
  pkgs,
  ...
}: {
  home.file.".prototools".source = ./.prototools;
  home.sessionPath = [
    "$HOME/.proto/tools/node/globals/bin"
    "$HOME/.proto/shims"
    "$HOME/.proto/bin"
  ];
  programs.zsh.sessionVariables = {
    PROTO_HOME = "$HOME/.proto";
    GOROOT = "$HOME/.go";
    GOBIN = "$HOME/.go/bin";
  };
  programs.zsh.initContent = lib.mkAfter ''
    (( $+commands[proto] )) && eval "$(proto activate zsh)"

    dotfiles-setup-dev() (
      set -e
      set -o pipefail
      if [[ ! -x "$PROTO_HOME/bin/proto" ]]; then
        local installer
        installer=$(mktemp)
        trap 'rm -f -- "$installer"' EXIT
        curl -fsSL https://moonrepo.dev/install/proto.sh -o "$installer"
        bash "$installer"
      fi
      "$PROTO_HOME/bin/proto" completions >| "$USER_ZSH_SITE_FUNCTIONS/_proto"
    )
  '';

  home.packages = with pkgs; [
    dprint
    imagemagick
    gh
    mkcert
    nss_latest
    nss_latest.tools
    nil
    nixd
    alejandra
  ];
}
