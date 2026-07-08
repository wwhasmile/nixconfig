{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.shell;
in {
  imports = [
    ./fastfetch.nix
  ];

  options = {
    homeSettings.shell = {
      enable = lib.mkEnableOption "Enable fancy shell";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;

        shellAliases = {
          neofetch = "fastfetch";
        };

        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.8.0";
              sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
            };
          }
          {
            name = "spaceship-prompt";
            file = "spaceship.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "spaceship-prompt";
              repo = "spaceship-prompt";
              rev = "v4.22.5";
              sha256 = "10c905cv2dybcqg2xigv60z71anaf1r6vlnfh83idhcjyc56048r";
            };
          }
        ];
      };

      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = config.programs.zsh.shellAliases;
      };

      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
      };

      direnv.enable = true;
    };

    home.packages = with pkgs; [
      curl
      wget
      gnugrep
      gnused
      unzip
      zip
      xz
    ];
  };
}
