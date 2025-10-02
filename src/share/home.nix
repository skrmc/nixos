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
    users.${user} = {
      home.stateVersion = "25.05";
      imports = [
        ./home/desktop.nix
        ./home/hyprland.nix
        ./home/programs.nix
      ];
    };
  };
}
