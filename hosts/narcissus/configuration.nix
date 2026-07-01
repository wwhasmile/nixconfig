{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  system.zenKernel.enable = true;
  system.mango.enable = true;

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "uk_UA.UTF-8";
  console = {
    font = "Lat2-Terminus32";
  };

  services.libinput.enable = true;
  users.users.wwhasmile = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    packages = with pkgs; [
      librewolf 
      tree

    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 25565 ];
  networking.firewall.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}

