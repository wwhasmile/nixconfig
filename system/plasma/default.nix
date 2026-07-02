{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.plasma;
in {
  options = {
    systemSettings.plasma = {
      enable = lib.mkEnableOption "Enable Plasma";
    };
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    services.xserver = {
      enable = true;
      xkb.options = "grp:alt_shift_toggle";
      excludePackages = with pkgs; [ xterm ];
    };

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
