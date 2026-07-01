{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.system.mango;
in {
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  options = {
    system.mango = {
      enable = lib.mkEnableOption "Enable MangoWM";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mango.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
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
