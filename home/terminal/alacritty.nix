{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.alacritty;
in {
  options = {
    homeSettings.alacritty = {
      enable = lib.mkEnableOption "Enable Alacritty terminal";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings.window.opacity = lib.mkForce 0.85;
    };

    stylix.targets.alacritty.enable = true;
  };
}