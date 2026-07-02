{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.browser;
in {
  options = {
    homeSettings.browser = {
      enable = lib.mkEnableOption "Enable browser";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ librewolf ];

    home.file.".librewolf/librewolf.overrides.cfg".text = ''
      defaultPref("browser.toolbars.bookmarks.visibility","never");
      defaultPref("privacy.resistFingerprinting.letterboxing", true);
      defaultPref("network.http.referer.XOriginPolicy", 2);
      defaultPref("librewolf.webgl.prompt", true);
      defaultPref("browser.sessionstore.resume_from_crash", false);
      defaultPref("browser.tabs.vertical", true);
    '';
  };
}
