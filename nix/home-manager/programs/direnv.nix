{...}: {
  programs.direnv.enable = true;
  programs.direnv.config = {
    global = {
      disable_stdin = true;
      load_dotenv = true;
    };
    whitelist = {
      prefix = ["~/Projects"];
    };
  };
}
