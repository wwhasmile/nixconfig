{ config, pkgs, ... }:

{
  homeSettings = {
    name = "wwhasmile";
    email = "uwuhasmile@proton.me";

    shell.enable = true;
    fastfetch.enable = true;

    keepass.enable = true;
    browser.enable = true;
    chat.enable = true;

    media.enable = true;
    recording.enable = true;

    art.enable = true;

    vscodium.enable = true;

    gaming.steam = true;
    gaming.minecraft = true;
    gaming.itch = true;
    gaming.dosbox = true;

    git.enable = true;

    stylix.enable = true;
    gnome.enable = true;
  };

  programs.vscodium.profiles.default = {
    extensions =  with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.lldb-dap
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
      ziglang.vscode-zig
    ];
    userSettings = {
      "zig.zls.enabled" = "on";
    };
  };

  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        narcissus = {
	  addresses = [ "dynamic" ];
	  id = "OZAD3KU-BZM4FB4-PT4KTTP-GL5HXWT-DWIUSWP-PAW5KJM-2IKWLYZ-KGCAJA2";
	};
        redmi = {
          addresses = [ "dynamic" ];
          id = "GULJ7IP-HNJ4FYL-Z2D5LKP-J6ANA2P-WWSYVNO-LSJPFBJ-RY24DD4-GLYOTQZ";
        };
      };

      folders = {
        "Passwords" = {
          path = "/home/wwhasmile/.keepass";
          devices = [ "narcissus" "redmi" ];
        };
        "SSH" = {
          path = "/home/wwhasmile/.ssh";
	  devices = [ "narcissus" ];
          ignorePerms = false;
        };
      };
    };
  };

  home.stateVersion = "26.05";
}
