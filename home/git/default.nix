{ config, lib, pkgs, pkgs-stable, ... }:

let
  cfg = config.homeSettings.git;
in {
  options = {
    homeSettings.git = {
      enable = lib.mkEnableOption "Enable Git";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.git
      pkgs.git-extras
      pkgs.git-filter-repo
      pkgs-stable.openssh
    ];

    programs.git = {
      enable = true;
      lfs.enable = true;
      extraConfig.init.defaultBranch = "main";
    };
  };
}
