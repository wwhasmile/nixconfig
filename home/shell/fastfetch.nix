{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.fastfetch;
in {
  options = {
    homeSettings.fastfetch = {
      enable = lib.mkEnableOption "Enable fastfetch in shell";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fastfetch
    ];

    programs = {
      fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "small";
            padding.left = 4;
          };
          display.separator = "  ";
          modules = [
            {
              key = "{icon}";
              type = "os";
            }
            {
              key = "󰇄";
              type = "de";
            }
            {
              key = "󰍛";
              type = "cpu";
            }
            {
              key = "";
              type = "memory";
            }
            {
              key = "󰅐";
              type = "uptime";
            }
          ];
        };
      };

      zsh.initContent = ''
        fastfetch
      '';
    };
  };
}