{ config, lib, pkgs, ... }:

{
  system.users = [ "wwhasmile" ];
  system.admins = [ "wwhasmile" ];

  system.region = {
    timezone = "Europe/Kyiv";
    language = "uk_UA.UTF-8";
  };

  system.zenKernel.enable = true;

  system.bluetooth.enable = true;

  system.plasma.enable = true;

  system.firewalld.enable = true;
  system.gpg.enable = true;
  system.sshd.enable = false;

  system.gaming.enable = true;

  system.docker.enable = true;

  services.libinput.enable = true;
  users.users.wwhasmile = {
    description = "Hasmile";
    packages = with pkgs; [
      librewolf 
      tree
    ];
  };

  services.xserver.xkb.layout = "us,ua";

  system.stateVersion = "26.05"; # Did you read the comment?

}

