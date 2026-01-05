# /etc/nixos/src/share/overlays.nix

{ pkgs, inputs, ... }:

{
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        hyprland = inputs.hyprland.packages.${final.stdenv.hostPlatform.system}.hyprland;
        xdg-desktop-portal-hyprland =
          inputs.hyprland.packages.${final.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        # hyprlandPlugins.hyprexpo = inputs.hyprland-plugins.packages.${final.stdenv.hostPlatform.system}.hyprexpo;
      })
    ];
  };
}
