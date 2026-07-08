{ config, lib, ... }:

let
  cfg = config.systemSettings.tlp;
in {
  options = {
    systemSettings.tlp = {
      enable = lib.mkEnableOption "Enable tlp for laptop battery management";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      power-profiles-daemon.enable = lib.mkForce false;
      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance-power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 70;

          START_CHARGE_THRESH_BAT0 = 40;
          STOP_CHARGE_THRESH_BAT0 = 80;

          MEM_SLEEP_ON_AC = "deep";
          MEM_SLEEP_ON_BAT = "deep";
        };
      };
    };
  };
}