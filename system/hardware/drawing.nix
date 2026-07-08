{ config, lib, ... }:

let
  cfg = config.systemSettings.drawing;
in {
  options = {
    systemSettings.drawing = {
      enable = lib.mkEnableOption "Enable graphic tablet support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = lib.mkForce true;
    boot.kernelModules = [ "uinput" ];
  };
}
