{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.media;
in {
  options = {
    homeSettings.media = {
      enable = lib.mkEnableOption "Enable VLC media player and codecs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vlc
      ffmpeg
      libva
    ];
  };
}