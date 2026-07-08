{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.zenKernel;
in {
  options = {
    systemSettings.zenKernel = {
      enable = lib.mkEnableOption "Enable zen kernel";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_zen;
  };
}
