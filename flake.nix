# /etc/nixos/flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs =
    { self, ... }@inputs:
    let
      theme = builtins.fromTOML (builtins.readFile ./theme.toml);
      mkSystem =
        host: user:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs host user;
            colors = theme.colors;
            fonts = theme.fonts;
          };
          modules = [
            inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
            inputs.nixvim.nixosModules.nixvim
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
      nixosConfigurations.KAGURA = mkSystem "KAGURA" "anon";
      nixosConfigurations.SAKUYA = mkSystem "SAKUYA" "anon";
      nixosConfigurations.HARUKA = mkSystem "HARUKA" "anon";
    };
}
