{ config, lib, pkgs, ... }:

{
  systemSettings = {
    users = [ "wwhasmile" ];
    admins = [ "wwhasmile" ];

    # Need to manage power since it's a laptop.
    tlp.enable = true;

    # It's a system used as a desktop.
    zenKernel.enable = true;

    # But also it's a laptop :)
    bluetooth.enable = true;
    # And I draw.
    drawing.enable = true;

    mango.enable = true;

    # Security
    firewalld.enable = true;
    gpg.enable = true;
    sshd.enable = false;

    # idk yet
    docker.enable = false;

    # Obviously I will game here some.
    gaming.enable = true;

    stylix.enable = true;
  };

  users.users.wwhasmile.description = "Hasmile";

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "uk_UA.UTF-8";
  # I need to have a proper layout.
  services.xserver.xkb.layout = "us,ua";

  system.stateVersion = "26.05";
}
