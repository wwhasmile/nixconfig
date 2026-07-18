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
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Mint-Y";
        package = pkgs.mint-y-icons;
      };
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
      bibata-cursors
    ];
  };
}
