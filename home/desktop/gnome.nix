{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.gnome;
in {
  options = {
    homeSettings.gnome = {
      enable = lib.mkEnableOption "Enable GNOME with home configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    gtk.cursorTheme = {
      package = pkgs.bibata-cursors;
      name = if config.stylix.polarity == "dark" then "Bibata Modern Classic" else "Bibata Modern Ice";
      size = 24;
    };

    stylix.targets = {
      gtk.enable = lib.mkForce true;
      gnome.enable = true;
    };

    home.packages = with pkgs; [
      gnome-themes-extra
      libadwaita
      adwaita-icon-theme
      adwaita-icon-theme-legacy
      adwaita-qt
      adwaita-qt6
    ];
  };
}