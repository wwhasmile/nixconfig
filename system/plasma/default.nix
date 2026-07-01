{ config, lib, pkgs, ... }:

let
  cfg = config.system.plasma;
in {
  options = {
    system.plasma = {
      enable = lib.mkEnableOption "Enable Plasma";
    };
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    # Audio
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
