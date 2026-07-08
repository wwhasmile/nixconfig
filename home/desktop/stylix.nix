{ config, lib, pkgs, osConfig, ... }:

let
  cfg = config.homeSettings.stylix;
  systemCfg = osConfig.systemSettings.stylix;
  theme = import ../../themes/${config.homeSettings.stylix.theme} pkgs;
in {
  options = {
    homeSettings.stylix = {
      enable = lib.mkEnableOption "Enable system wise Stylix theming";
      theme = lib.mkOption {
        type = lib.types.enum (builtins.readDir ../../themes
          |> lib.filterAttrs (name: type: type == "directory")
          |> builtins.attrNames
        );
        description = "System wise theme";
        default = if systemCfg.enable then systemCfg.theme else "github-dark";
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

        sizes = {
          terminal = 15;
          applications = 12;
          popups = 12;
          desktop = 12;
        };
      };

      targets = {
        kde.enable = true;
        qt.enable = true;
        gtk.enable = true;
      };
    };
    
    home.packages = with pkgs; [
      nerd-fonts.terminess-ttf
      ubuntu-sans 
      twitter-color-emoji
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ config.stylix.fonts.monospace.name ];
        sansSerif = [ config.stylix.fonts.sansSerif.name ];
        serif = [ config.stylix.fonts.serif.name ];
      };
    };
  };
}
