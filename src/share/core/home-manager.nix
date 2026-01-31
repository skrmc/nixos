{
  colors,
  fonts,
  user,
  ...
}:

{
  home-manager.extraSpecialArgs = { inherit colors fonts; };

  home-manager.users.root.home.stateVersion = "25.05";
  home-manager.users.${user}.home.stateVersion = "25.05";
}
