{ config, pkgs, ... }:

{
  homeSettings = {
    name = "wwhasmile";
    email = "uwuhasmile@proton.me";

    browser.enable = true;
    chat.enable = true;

    git.enable = true;
  };

  home.packages = with pkgs; [
    fastfetch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
