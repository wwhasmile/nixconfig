{
  description = "Hasmile's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      lib = inputs.nixpkgs.lib;
      
      hosts = builtins.readDir ./hosts |>
        lib.filterAttrs (name: value: value == "directory") |>
        builtins.attrNames;
    in {
      nixosConfigurations = lib.genAttrs hosts (host:
        lib.nixosSystem {
          inherit system;
          inherit pkgs;

          modules = [
            { networking.hostName = host; }
            (./hosts + "/${host}")

            ./system

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit pkgs;
                inherit pkgs-stable;
                inherit inputs;
              };
            }
          ];
          specialArgs = {
            inherit pkgs-stable;
            inherit inputs;
          };
        }
      );
    };
}
