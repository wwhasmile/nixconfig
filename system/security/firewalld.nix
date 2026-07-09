{ config, lib, ... }:

let
  cfg = config.systemSettings.firewalld;
in {
  options = {
    systemSettings.firewalld = {
      enable = lib.mkEnableOption "Enable firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 8384 ]; # Syncthing
    };
  };
}
