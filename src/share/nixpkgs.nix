# /etc/nixos/src/share/overlays.nix

{
  pkgs,
  inputs,
  user,
  ...
}:

{
  nix.settings = {
    trusted-users = [ user ];
    substituters = [
      "https://sakura.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "sakura.cachix.org-1:2G6sCOA1m16cMKsRLpcNEnPiXNgtTwM5zkOvkLYHRFc="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.fenix.overlays.default
      (final: prev: {
        niri = inputs.niri.packages.${final.stdenv.hostPlatform.system}.niri;
        # hyprland = inputs.hyprland.packages.${final.stdenv.hostPlatform.system}.hyprland;
        # xdg-desktop-portal-hyprland = inputs.hyprland.packages.${final.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        # hyprlandPlugins.hyprexpo = inputs.hyprland-plugins.packages.${final.stdenv.hostPlatform.system}.hyprexpo;
      })
    ];
  };
}
