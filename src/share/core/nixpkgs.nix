{ inputs, user, ... }:
{
  nix.settings = {
    trusted-users = [ user ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://sakura.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "sakura.cachix.org-1:2G6sCOA1m16cMKsRLpcNEnPiXNgtTwM5zkOvkLYHRFc="
    ];
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.fenix.overlays.default ];
  };

  programs = {
    nix-index-database.comma.enable = true;
    nh = {
      enable = true;
      flake = "/home/${user}/.config/nixos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 30d";
      };
    };
  };
}
