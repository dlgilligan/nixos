{
  ...
}:
{
  home.stateVersion = "25.11";
  imports = [
    ./labwc.nix
    ./waybar.nix
    ./rofi.nix
    ./zsh.nix
    ./tmux.nix
    ./neovim.nix
    ./alacritty.nix
  ];
  labwc.scale = true;
}
