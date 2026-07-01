{ config, lib, pkgs, ... }:

let
  cfg = config.system.zenKernel;
in {
    options = {
      system.zenKernel = {
        enable = lib.mkEnableOption "Enable zen kernel";
      };
    };

    config = lib.mkIf cfg.enable {
      boot.kernelPackages = pkgs.linuxPackages_zen;
    };
  }
