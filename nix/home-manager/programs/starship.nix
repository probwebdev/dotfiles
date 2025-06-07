{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 500;
      format = lib.concatStrings [
        "[┌](green) $username$hostname$sudo"
        "$line_break"
        "[│](green) $directory$git_status$git_branch$git_state$nodejs$deno$bun$docker_context"
        "$line_break"
        "[└](green) $character"
      ];
      character = {
        format = "$symbol (bold green)";
        success_symbol = "[λ](bold green)";
        error_symbol = "[✘](bold red)";
        vicmd_symbol = "[⮜](bold green)";
        disabled = false;
      };
      username = {
        style_user = "bold green";
        style_root = "bold red";
        format = "[$user]($style)";
        show_always = true;
        disabled = false;
      };
      hostname = {
        ssh_only = true;
        format = "[@$hostname]($style)";
        style = "bold dimmed green";
        disabled = false;
      };
      sudo = {
        format = "[ $symbol]($style)";
        style = "bold yellow";
        symbol = "🗲";
        disabled = false;
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = "…/";
        style = "bold italic yellow";
        disabled = false;
      };
      docker_context = {
        disabled = false;
      };
      nodejs = {
        symbol = "⬢ ";
      };
    };
  };
}
