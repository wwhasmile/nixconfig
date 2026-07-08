{ lib, ... }:

{
  imports = lib.filesystem.listFilesRecursive ./. |>
    lib.filter (file: lib.strings.hasSuffix ".nix" file && file != ./default.nix);
}