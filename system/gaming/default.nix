{ config, lib, pkgs, ... }:

let
  cfg = config.system.gaming;
in {
  options = {
    system.gaming = {
      enable = lib.mkEnableOption "Enable gaming";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    programs.gamemode.enable = true;
  };
}
