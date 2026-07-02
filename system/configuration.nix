{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ git ];

    services.timesyncd.enable = true;
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

    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;

    console = {
      font = "ter-v32n";
      packages = with pkgs; [ terminus_font ];
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.udev.log_level=3"
      "loglevel=3"
    ];
    boot.plymouth.enable = true;

    networking.networkmanager.enable = true;

    programs.nano.enable = lib.mkForce false;

    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  };
}
