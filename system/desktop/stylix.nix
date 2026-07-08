{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.systemSettings.stylix;
  theme = import ../../themes/${config.systemSettings.stylix.theme} pkgs;
in {
  imports = [ inputs.stylix.nixosModules.stylix ];

  options = {
    systemSettings.stylix = {
      enable = lib.mkEnableOption "Enable system wise Stylix theming";
      theme = lib.mkOption {
        type = lib.types.enum (builtins.readDir ../../themes
          |> lib.filterAttrs (name: type: type == "directory")
          |> builtins.attrNames
        );
        description = "System wise theme";
        default = "github-dark";
      };
    };
  };
  
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;

      base16Scheme = theme.scheme;
      polarity = theme.polarity;
      image = pkgs.fetchurl theme.background;

      fonts = {
        monospace = {
          name = "Terminess Nerd Font";
          package = pkgs.nerd-fonts.terminess-ttf;
        };

        serif = {
          name = "Ubuntu Sans";
          package = pkgs.ubuntu-sans;
        };

        sansSerif = {
          name = "Ubuntu Sans";
          package = pkgs.ubuntu-sans;
        };

        emoji = {
          name = "Twitter Color Emoji";
          package = pkgs.twitter-color-emoji;
        };
      };

      targets = {
        console.enable = true;
        chromium.enable = true;
      };
    };
  };
}
