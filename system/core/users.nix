{ config, lib, ... }:

{
  options = {
    systemSettings = {
      users = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of desktop users of this machine";
      };
      admins = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of users of this machine with root privileges";
      };
    };
  };

  config = {
    users.users = lib.genAttrs config.systemSettings.users (user: {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "video" "render" ] ++ (if builtins.elem user config.systemSettings.admins then [ "wheel" ] else [ ]);
    });

    home-manager.users = lib.genAttrs config.systemSettings.users (user: {
      home.username = user;
      home.homeDirectory = "/home/${user}";
    });
  };
}
