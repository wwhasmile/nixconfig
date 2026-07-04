{ config, pkgs, ... }:

{
  homeSettings = {
    name = "wwhasmile";
    email = "uwuhasmile@proton.me";

    shell.enable = true;

    keyguard.enable = true;
    browser.enable = true;
    chat.enable = true;

    art.enable = true;

    vscodium.enable = true;

    gaming.steam = true;
    gaming.itch = true;
    gaming.dosbox = true;

    git.enable = true;
  };

  programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.lldb-dap
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
