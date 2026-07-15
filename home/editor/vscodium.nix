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
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode.cmake-tools
          ziglang.vscode-zig
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "debug";
            publisher = "webfreak";
            version = "0.27.0";
            sha256 = "sha256-p/k5UcXldXKFKbPbnW603Jsut53n01azeDhWMDSd4nw="; 
          }
        ];
        userSettings = {
          "editor.rulers" = [ 120 ];
          "zig.zls.enabled" = "on";
        };
      };

      mutableExtensionsDir = false;
    };

    stylix.targets.vscodium.enable = true;
  };
}
