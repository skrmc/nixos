{
  imports = [
    ./system.nix
    ./users.nix
    ./home.nix

    ./modules/battery.nix
    ./modules/fonts.nix
    ./modules/neovim.nix
    ./modules/programs.nix
  ];
}
