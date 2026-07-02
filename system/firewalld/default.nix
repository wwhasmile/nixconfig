{ config, lib, ... }:

let
  cfg = config.systemSettings.firewalld;
in {
  options = {
    systemSettings.firewalld = {
      enable = lib.mkEnableOption "Enable firewall";
      tcpPorts = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        description = "TCP ports to open";
      };
    udpPorts = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        description = "UDP ports to open";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = cfg.tcpPorts;
      allowedUDPPorts = cfg.udpPorts;
    };
  };
}
