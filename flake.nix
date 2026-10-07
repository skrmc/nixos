{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      impermanence,
      home-manager,
      stylix,
      treefmt-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      hosts = [
        "SAKURA"
        "SAKUYA"
        "KAGURA"
        "HARUKA"
      ];
      user = "anon";

      eachSystem = lib.genAttrs systems;
      treefmtEval = eachSystem (
        system: treefmt-nix.lib.evalModule (import nixpkgs { inherit system; }) ./treefmt.nix
      );
      mkSystem =
        host:
        lib.nixosSystem {
          specialArgs = {
            inherit inputs host user;
          };
          modules = [
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            ./src/hosts/${host}
            ./src/share
          ];
        };
    in
    {
      formatter = eachSystem (system: treefmtEval.${system}.config.build.wrapper);

      checks = eachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      nixosConfigurations = lib.genAttrs hosts mkSystem;
    };
}
