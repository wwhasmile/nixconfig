{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.vscodium;
in {
  options =  {
    homeSettings.vscodium = {
      enable = lib.mkEnableOption "Enable VSCodium code editor";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscodium = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          mkhl.direnv
          yzhang.markdown-all-in-one
          llvm-vs-code-extensions.vscode-clangd
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vshaxe";
            publisher = "nadako";
            version = "2.34.1004";
            hash = "sha256-3x5l2Qha6Olah9JLjLC2W4bDmdJ4ajycIQeQHvVj2ao=";
          }
          {
            name = "codedox";
            publisher = "wiggin77";
            version = "1.3.3";
            hash = "sha256-OyV6HLmm1bayM3StDkE33+dX1D1rALmbm4L6fEANFGk=";
          }
          {
            name = "haxe-checkstyle";
            publisher = "vshaxe";
            version = "1.8.3";
            hash = "sha256-oOo7o1k0Er1txWUf69R6HuKyqpHwlpAol54KpKiWehk=";
          }
          {
            name = "haxe-hl";
            publisher = "HaxeFoundation";
            version = "1.4.34";
            hash = "sha256-nuEPGPFOp4zkAwR18/yibIzN1dlBj23X7n+Cnskaacc=";
          }
        ];

        userSettings = {
          "hldebug.connectionTimeout" = 10;
        };
      };
    };

    stylix.targets.vscodium.enable = true;
  };
}
