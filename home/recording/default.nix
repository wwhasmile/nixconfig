{ config, lib, pkgs, pkgs-stable, ... }:

let
  cfg = config.homeSettings.recording;
in {
  options = {
    homeSettings.recording = {
      enable = lib.mkEnableOption "Enable OBS Studio, Tenacity, and Kdenlive";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-gstreamer
        obs-vaapi
      ];
    };

    home.packages = with pkgs-stable; [
      kdePackages.kdenlive
      tenacity
    ];
  };
}