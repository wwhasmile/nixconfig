{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.zed;
in {
  options =  {
    homeSettings.zed = {
      enable = lib.mkEnableOption "Enable Zed code editor";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zed-editor
    ];

    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "toml"
        "make"
        "csharp"
        "haxe"
        "editorconfig"
        "git-firefly"
        "catppuccin-icons"
      ];

      userSettings = {
        cursor_blink = false;

        session.restore_unsaved_buffers = false;
        restore_on_startup = "empty_tab";

        icon_theme = {
          mode = "system";
          light = "Catppuccin Mocha";
          dark = "Catppuccin Mocha";
        };

        toolbar = {
          code_actions = true;
          agent_review = false;
          breadcrumbs = true;
        };

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        disable_ai = true;

        git_panel.button = true;
        collaboration_panel.button = false;

        bottom_dock_layout = "contained";

        load_direnv = "shell_hook";
        vim_mode = true;
        vim.use_system_clipboard = "on_yank";
      };
    };

    stylix.targets.zed.enable = true;
  };
}
