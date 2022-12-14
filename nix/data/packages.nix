{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.common.lib.__inputs__) nixpkgs-hardenedlinux;
in {
  inherit
    (nixpkgs-hardenedlinux.packages.${nixpkgs.system})
    tuc
    zed
    ;
}
