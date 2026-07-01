{ lib, config, ... }:

let
  cfg = config.system.gpg;
in {
  options = {
    system.gpg = {
      enable = lib.mkEnableOption "Enable GPG";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
