{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.chat;
in {
  options = {
    homeSettings.chat = {
      enable = lib.mkEnableOption "Enable my chatting apps";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      telegram-desktop
    ];
  };
}
