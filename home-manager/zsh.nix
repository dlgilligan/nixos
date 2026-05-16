{
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmux" ];
      theme = "dst";
    };

    sessionVariables = {
      ZSH_TMUX_AUTOSTART = "true";
      ZSH_TMUX_AUTOCONNECT = "true";
    };
  };
}
