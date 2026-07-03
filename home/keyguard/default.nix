{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.keyguard;
in {
  options = {
    homeSettings.keyguard = {
      enable = lib.mkEnableOption "Enable Keyguard, alternative Bitwarden password manager client.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      keyguard
    ];
  };
}
