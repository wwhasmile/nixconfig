{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ git ];

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

    networking.networkmanager.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  };
}
