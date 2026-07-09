{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.keepass;
in {
  options = {
    homeSettings.keepass = {
      enable = lib.mkEnableOption "Enable KeePassXC for managing passwords.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      keepassxc
    ];
  };
}
