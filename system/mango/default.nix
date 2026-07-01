{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.system.mango;
in {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    options = {
      system.mango = {
        enable = lib.mkEnableOption "Enable MangoWM";
      };
    };

    config = lib.mkIf cfg.enable {
      programs.mango.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  }
