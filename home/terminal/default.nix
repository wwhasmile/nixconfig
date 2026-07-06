{ config, lib, ... }:

{
  options = {
    homeSettings.terminal = lib.mkOption {
      type = lib.types.enum [ "alacritty" ];
      default = "alacritty";
      description = "Default terminal to use";
    };
  };

  config = {
    homeSettings.alacritty.enable = lib.mkForce (config.homeSettings.terminal == "alacritty");
  };
}