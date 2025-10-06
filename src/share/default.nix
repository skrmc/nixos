# /etc/nixos/src/share/default.nix
{
  imports = [
    # ./overlays.nix
    ./system.nix
    ./users.nix
    ./home.nix
  ];
}
