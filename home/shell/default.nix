{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.shell;
in {
  options = {
    homeSettings.shell = {
      enable = lib.mkEnableOption "Enable fancy shell";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      shellAliases = {
        neofetch = "fastfetch";
      };

      initContent = ''
        fastfetch
      '';

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

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = config.programs.zsh.shellAliases;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    home.packages = with pkgs; [
      fastfetch
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
