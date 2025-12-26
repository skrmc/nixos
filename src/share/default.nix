# /etc/nixos/src/share/default.nix
{
  imports = [
    ./nixpkgs.nix
    ./system.nix
    ./users.nix
    ./home.nix
  ];
}
