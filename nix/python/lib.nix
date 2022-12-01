{
  inputs,
  cell,
} @ args: {
  poetryPackages = import ./packages/poetryPackages.nix args;

  nixpkgs = inputs.dataflow2nix.prefect.lib.nixpkgs.appendOverlays [
  # nixpkgs = inputs.cells.common.lib.nixpkgs.appendOverlays [
    inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.python.overlays.default
    inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.common.lib.__inputs__.rust-overlay.overlays.default
  ];
}
