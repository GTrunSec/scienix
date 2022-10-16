{
  inputs,
  cell,
}: {
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.julia2nix.overlays.default
    inputs.poetry2nix.overlay
    cell.overlays.default
    # inputs.cells.lib.__inputs__.poe
  ];
}
