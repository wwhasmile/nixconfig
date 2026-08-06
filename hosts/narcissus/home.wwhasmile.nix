{ config, pkgs, ... }:

{
  homeSettings = {
    name = "wwhasmile";
    email = "uwuhasmile@proton.me";

    shell.enable = true;
    fastfetch.enable = true;

    keepass.enable = true;
    librewolf.enable = true;
    chat.enable = true;

    media.enable = true;
    recording.enable = true;

    art.enable = true;

    zed.enable = true;

    gaming.steam = true;
    gaming.itch = true;
    gaming.dosbox = true;

    git.enable = true;

    stylix.enable = true;
    gnome.enable = true;
  };

  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        nostromo = {
          addresses = [ "dynamic" ];
          id = "CA24JZA-OA5SSVM-CKBNFBQ-ZZC3DCF-DDLIEBX-WK5AUBD-VKSGWQQ-KH5SUQR";
        };
        redmi = {
          addresses = [ "dynamic" ];
          id = "GULJ7IP-HNJ4FYL-Z2D5LKP-J6ANA2P-WWSYVNO-LSJPFBJ-RY24DD4-GLYOTQZ";
        };
      };

      folders = {
        "Passwords" = {
          path = "/home/wwhasmile/.keepass";
          devices = [ "nostromo" "redmi" ];
        };
        "SSH" = {
          path = "/home/wwhasmile/.ssh";
          devices = [ "nostromo" ];
          ignorePerms = false;
        };
      };
    };
  };

  home.stateVersion = "26.05";
}
