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
    tailscale
    kubectl
    kustomize
    kubebuilder
    kubernetes-helm
    ansible
    go
    gnumake
    gcc
    nodejs_20
    pnpm
    jdk17
    maven
  ];
  services.tailscale.enable = true;

  fonts.packages = with pkgs; [
    unifont
    nerd-fonts.symbols-only
  ];
}
