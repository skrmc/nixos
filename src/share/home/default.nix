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
        ./tools.nix
      ];
    };
    users.${user} = {
      home.stateVersion = "25.05";
      imports = [
        ./desktop
        ./tools.nix
      ];
    };
  };
}
