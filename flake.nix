# /etc/nixos/flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:skrmc/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, ... }@inputs:
    let
      mkSystem = name:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs name; };
          modules = [
            ./src/share
            ./src/hosts/${name}
            inputs.nixvim.nixosModules.nixvim
            inputs.home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
    in
    {
      nixosConfigurations.SAKURA = mkSystem "SAKURA";
      nixosConfigurations.KAGURA = mkSystem "KAGURA";
      nixosConfigurations.HARUKA = mkSystem "HARUKA";
    };
}