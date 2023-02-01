{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
in {
  inherit
    (__inputs__.vast2nix.packages.${inputs.nixpkgs.system})
    vast-bin
    ;
}
