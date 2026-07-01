{ lib, ... }:

with lib;
let
  imports = builtins.readDir ./. |>
    lib.filterAttrs (name: value:
      (value == "directory" && builtins.pathExists ./${name}/default.nix) ||
      (lib.hasSuffix ".nix" name && name != "default.nix")
    ) |>
    builtins.attrNames |>
    map (x: (toString ./.) + "/${x}");
in {
    inherit imports;
  }
