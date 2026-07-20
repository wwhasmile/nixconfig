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

      extensions = [ "nix" "toml" "make" "csharp" ];

      userSettings = {
        cursor_blink = false;

        session.restore_unsaved_buffers = false;
        restore_on_startup = "empty_tab";

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
        agent.button = false;
        assistant.enable = false;

        git_panel.button = true;
        collaboration_panel.buttom = false;
        chat_panel.button = false;

        bottom_dock_layout = "contained";

        load_direnv = "shell_hook";
        vim_mode = true;
        vim.use_system_clipboard = "on_yank";
      };
    };

    stylix.targets.zed.enable = true;
  };
}
