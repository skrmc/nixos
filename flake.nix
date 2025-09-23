# /etc/nixos/flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager"; # release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      mkSystem =
        host: user:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs host user; };
          modules = [
            ./src/share
            ./src/hosts/${host}
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
      nixosConfigurations.SAKURA = mkSystem "SAKURA" "anon";
      nixosConfigurations.KAGURA = mkSystem "KAGURA" "anon";
      nixosConfigurations.SAKUYA = mkSystem "SAKUYA" "anon";
      nixosConfigurations.HARUKA = mkSystem "HARUKA" "anon";
    };
}
