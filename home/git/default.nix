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

      settings = {
        user = {
          name = config.homeSettings.name;
          email = config.homeSettings.email;
        };
        init.defaultBranch = "main";
      };

      lfs.enable = true;
    };
  };
}
