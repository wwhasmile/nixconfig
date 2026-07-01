{ config, lib, ... }:

let
  cfg = config.system.bluetooth;
in {
  options = {
    system.bluetooth = {
      enable = lib.mkEnableOption "Enable Bluetooth";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
