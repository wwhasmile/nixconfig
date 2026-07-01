{ config, lib, ... }:

let
  cfg = config.system.region;
in {
  options = {
    system.region = {
      timezone = lib.mkOption {
        type = lib.types.str;
        description = "System timezone";
      };

      language = lib.mkOption {
        type = lib.types.str;
        description = "System language, sans console messages";
      };
    };
  };

  config = {
      time.timeZone = cfg.timezone;

      i18n.defaultLocale = cfg.language;
      i18n.extraLocaleSettings = with config; {
        LC_ADDRESS = cfg.language;
        LC_IDENTIFICATION = cfg.language;
        LC_MEASUREMENT = cfg.language;
        LC_MONETARY = cfg.language;
        LC_NAME = cfg.language;
        LC_NUMERIC = cfg.language;
        LC_PAPER = cfg.language;
        LC_TELEPHONE = cfg.language;
        LC_TIME = cfg.language;
        LC_MESSAGES = "en_US.UTF-8";
      };
    };
}
