{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.docker;
in {
  options = {
    systemSettings.docker = {
      enable = lib.mkEnableOption "Enable Docker";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
