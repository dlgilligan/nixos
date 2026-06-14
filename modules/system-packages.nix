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
    usbutils
    firefox
    fastfetch
    kubernetes-helm
    ansible
  ];

  fonts.packages = with pkgs; [
    unifont
    nerd-fonts.symbols-only
  ];
}
