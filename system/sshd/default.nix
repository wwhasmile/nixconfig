{ config, lib, ... }:

let
  cfg = config.system.sshd;
in {
  options = {
    system.sshd = {
      enable = lib.mkEnableOption "Enable remote SSH access";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentification = false;
        PermitRootLogin = "no";
      };
    };
  };
}
