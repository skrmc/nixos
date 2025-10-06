# /etc/nixos/flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager"; # release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    # hyprland-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, ... }@inputs:
    let
      # https://material-foundation.github.io/material-theme-builder
      colors = builtins.fromJSON (builtins.readFile ./colors.json);
      fonts = {
        sans = "IBM Plex Sans";
        serif = "IBM Plex Serif";
        mono = "FiraCode Nerd Font";
      };
      mkSystem =
        host: user:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              colors
              fonts
              host
              user
              ;
          };
          modules = [
            ./src/share
            ./src/hosts/${host}
            inputs.home-manager.nixosModules.home-manager
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.nixvim.nixosModules.nixvim
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
