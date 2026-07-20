{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.gnome;
in {
  options = {
    systemSettings.gnome = {
      enable = lib.mkEnableOption "Enable GNOME desktop environment";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        # Removing bloat
        core-apps.enable = false;
        core-developer-tools.enable = false;
        games.enable = false;
      };
    };

    # But adding the minimally necessary packages
    environment = {
      # Removing bloat
      gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
      systemPackages = with pkgs; [
        gnome-text-editor
        gnome-characters
        gnome-font-viewer
        nautilus
        loupe
        wl-clipboard

        alsa-utils
      ];
    };
    hardware.alsa.enablePersistence = true;
  };
}
