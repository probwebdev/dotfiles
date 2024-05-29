_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf-tmux --preview 'eza --tree --level=2 --color=always --git {} | head -200' "$@" ;;
    export|unset) fzf-tmux --preview "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf-tmux --preview 'dig {}' "$@" ;;
    *)            fzf-tmux --preview 'less {}' "$@" ;;
  esac
}

fzf-tmux() {
  command fzf-tmux $FZF_TMUX_OPTS "$@"
}
