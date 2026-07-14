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

    home.file.".config/librewolf/librewolf/librewolf.overrides.cfg".text = ''
      defaultPref("sidebar.verticalTabs", true);
      defaultPref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
      defaultPref("privacy.resistFingerprinting.letterboxing", true);
      defaultPref("network.http.referer.XOriginPolicy", 2);
      defaultPref("librewolf.webgl.prompt", true);
      defaultPref("browser.sessionstore.resume_from_crash", false);
      defaultPref("middlemouse.paste", false);
      defaultPref("general.autoScroll", true);
      defaultPref("privacy.resistFingerprinting", false);
      defaultPref("privacy.fingerprintingProtection", true);
      defaultPref("privacy.fingerprintingProtection.overrides", +AllTargets,-CSSPrefersColorScheme);

      pref("middlemouse.paste", false);
      pref("general.autoScroll", true);
      pref("privacy.resistFingerprinting", false);
      pref("privacy.fingerprintingProtection", true);
      pref("privacy.fingerprintingProtection.overrides", +AllTargets,-CSSPrefersColorScheme);
    '';
  };
}
