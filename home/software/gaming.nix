{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.gaming;
in {
  options = {
    homeSettings.gaming = {
      steam = lib.mkEnableOption "Enable Steam";
      minecraft = lib.mkEnableOption "Enable Prism Launcher for Minecraft";
      itch = lib.mkEnableOption "Enable itch.io client";
      dosbox = lib.mkEnableOption "Enable DosBox-X";
    };
  };

  config = {
    home.packages = with pkgs;
      (lib.optionals cfg.steam [ steam ])
      ++ (lib.optionals cfg.minecraft [ prismlauncher ])
      ++ (lib.optionals cfg.itch [ itch ])
      ++ (lib.optionals cfg.dosbox [ dosbox-x ]);
  };
}
