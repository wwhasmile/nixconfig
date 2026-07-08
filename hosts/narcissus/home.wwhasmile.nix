{ config, pkgs, ... }:

{
  homeSettings = {
    name = "wwhasmile";
    email = "uwuhasmile@proton.me";

    shell.enable = true;
    fastfetch.enable = true;

    keyguard.enable = true;
    browser.enable = true;
    chat.enable = true;

    media.enable = true;
    recording.enable = true;

    art.enable = true;

    vscodium.enable = true;

    gaming.steam = true;
    gaming.itch = true;
    gaming.dosbox = true;

    git.enable = true;

    stylix.enable = true;
  };

  programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.lldb-dap
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
  ];

  home.stateVersion = "26.05";
}
