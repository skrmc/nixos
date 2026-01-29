# /etc/nixos/src/share/home.nix

{
  colors,
  fonts,
  user,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit colors fonts; };
    users.root = {
      home.stateVersion = "25.05";
      imports = [
        ./home/tools.nix
      ];
    };
    users.${user} = {
      home.stateVersion = "25.05";
      imports = [
        ./home/desktop.nix
        ./home/tools.nix
      ];
    };
  };
}
