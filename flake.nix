{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.home-manager.follows = "home-manager";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:skrmc/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";

    # niri.url = "github:skrmc/niri";
    # niri.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "github:hyprwm/hyprland";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
  };

  outputs =
    { self, ... }@inputs:
    let
      mkSystem =
        host: user:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs host user;
          };
          modules = [
            inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            ./src/hosts/${host}
            ./src/share
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
    in
    {
      nixosConfigurations.SAKURA = mkSystem "SAKURA" "anon";
      nixosConfigurations.SAKUTA = mkSystem "SAKUTA" "anon";
      nixosConfigurations.SAKUYA = mkSystem "SAKUYA" "anon";
      nixosConfigurations.KAGURA = mkSystem "KAGURA" "anon";
    };
}
