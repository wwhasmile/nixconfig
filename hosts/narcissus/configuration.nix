{ config, lib, pkgs, ... }:

{
  config = {
    systemSettings = {
      users = [ "wwhasmile" ];
      admins = [ "wwhasmile" ];

      # It's a system used as a desktop.
      zenKernel.enable = true;

      # But also it's a laptop :)
      bluetooth.enable = true;

      # So far it's Plasma, later gonna replace with MangoWM.
      plasma.enable = true;

      # Security
      firewalld.enable = true;
      gpg.enable = true;
      sshd.enable = false;

      # idk yet
      docker.enable = false;

      # Obviously I will game here some.
      gaming.enable = true;
    };

    users.users.wwhasmile.description = "Hasmile";

    time.timeZone = "Europe/Kyiv";
    i18n.defaultLocale = "uk_UA.UTF-8";
    # I need to have a proper layout.
    services.xserver.xkb.layout = "us,ua";

    system.stateVersion = "26.05";
  };
}

