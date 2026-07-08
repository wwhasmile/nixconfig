{ config, lib, pkgs-stable, ... }:

let
  cfg = config.homeSettings.art;
in {
  options = {
    homeSettings.art = {
      enable = lib.mkEnableOption "Enable art software";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs-stable; [
      krita
      gimp
      inkscape
      google-fonts
    ];
  };
}
