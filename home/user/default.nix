{ config, lib, ... }:

{
  options = {
    homeSettings = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "User full name";
      };
      email = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "User email";
      };
    };
  };
}
