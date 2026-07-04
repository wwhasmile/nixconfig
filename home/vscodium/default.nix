{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.vscodium;
in {
  options = {
    homeSettings.vscodium = {
      enable = lib.mkEnableOption "Enable VSCodium, open source fork of VSCode text editor";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscodium = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          yzhang.markdown-all-in-one
          gruntfuggly.todo-tree
          jnoortheen.nix-ide
        ];
        userSettings = {
          "editor.rulers" = [ 120 ];
        };
      };

      mutableExtensionsDir = false;
    };
  };
}
