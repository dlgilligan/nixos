{
  description = "dlgilligan's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
    { 
      nixpkgs,
      home-manager,
      ... 
    }@inputs:
    {
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules
            ./hosts/t480/configuration.nix
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            { nixpkgs.config.allowUnfree = true; }
            home-manager.nixosModules.home-manager
            (
              { ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.daniel = import ./home-manager;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
              }
            )
          ];
          specialArgs = { inherit inputs; };
        };
        x1 = nixpkgs.lib.nixosSystem {
          modules = [
            ./modules
            ./hosts/x1/configuration.nix
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            { nixpkgs.config.allowUnfree = true; }
            home-manager.nixosModules.home-manager
            (
              { ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.daniel = import ./home-manager/x1.nix;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
              }
            )
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
