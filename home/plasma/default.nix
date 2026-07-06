{ config, lib, ... }:

let
  cfg = config.homeSettings.plasma;
in {
  options = {
    homeSettings.plasma = {
      enable = lib.mkEnableOption "Enable Plasma for user";
    };
  };

  config = lib.mkIf cfg.enable {
    qt.enable = lib.mkForce false;
    stylix = {
      targets = {
        gtk.enable = lib.mkForce false;
        qt.enable = lib.mkForce false;
        kde.enable = lib.mkForce true;
      };
    };
  };
}