{ config, lib, ... }:

let
  cfg = config.homeSettings.gnome;
in {
  options = {
    homeSettings.gnome = {
      enable = lib.mkEnableOption "Enable GNOME with home configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      gtk.enable = lib.mkForce true;
      gnome.enable = true;
    };
  };
}