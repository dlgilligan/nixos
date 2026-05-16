{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    alacritty
    zsh
    tmux
    vim
    neovim
    git
    wget
    pulseaudio
    firefox
    fastfetch
  ];

  fonts.packages = with pkgs; [
    unifont
    nerd-fonts.symbols-only
  ];
}
