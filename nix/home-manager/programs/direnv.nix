{...}: {
  programs.direnv.enable = true;
  programs.direnv.config = {
    global = {
      disable_stdin = true;
      hide_env_diff = true;
      load_dotenv = true;
    };
  };
}
