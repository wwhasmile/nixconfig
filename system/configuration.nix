{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ git ];

    i18n.extraLocaleSettings = with config; {
      LC_ADDRESS = i18n.defaultLocale;
      LC_IDENTIFICATION = i18n.defaultLocale;
      LC_MEASUREMENT = i18n.defaultLocale;
      LC_MONETARY = i18n.defaultLocale;
      LC_NAME = i18n.defaultLocale;
      LC_NUMERIC = i18n.defaultLocale;
      LC_PAPER = i18n.defaultLocale;
      LC_TELEPHONE = i18n.defaultLocale;
      LC_TIME = i18n.defaultLocale;
      LC_MESSAGES = "en_US.UTF-8";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  };
}
