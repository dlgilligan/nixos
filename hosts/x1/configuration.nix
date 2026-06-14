{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules
    ];

  # Modules
  labwc.enable = true;
  podman.enable = true;

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot Loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "x1";
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Misc
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # User
  users.users.daniel = {
    isNormalUser = true;
    home = "/home/daniel";
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "docker"
    ];
    hashedPassword = "$6$prA6f1PEv014OLYW$qo.OGvZwgMlIZpsKuep7l3Mr/4Wpywi16JGbev2MpC.PDkZ9cvX60.TzCh.WFGBTOQafc5tC/RpTfV5Z3/Dpc/";
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
