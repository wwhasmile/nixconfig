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

  system.mango.enable = true;

  system.firewalld.enable = true;
  system.gpg.enable = true;
  system.sshd.enable = false;

  system.docker.enable = true;

  services.libinput.enable = true;
  users.users.wwhasmile = {
    description = "Hasmile";
    packages = with pkgs; [
      librewolf 
      tree
    ];
  };

  system.stateVersion = "26.05"; # Did you read the comment?

}

