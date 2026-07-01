{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  config = {
    home-manager.users = lib.genAttrs config.system.users (user: {
      imports = [
        ./${user}.nix
        ../../home
      ];
    });
  };
}

