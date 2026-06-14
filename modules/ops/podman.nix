{ 
  config,
  lib,
  pkgs,
  ...
}: {
  options.podman.enable = lib.mkEnableOption "Enable podman";

  config = lib.mkIf config.podman.enable {
    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];
    virtualisation = {
      podman = {
        enable = true;
        # Create `docker` alias
        dockerCompat = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings = { dns_enabled = true; };
      };
    };
  };
}
