{
  inputs,
  cell,
}: {
  nixpkgs = inputs.cells._automation.lib.nixpkgs.appendOverlays [
    inputs.julia2nix.overlays.default
    cell.overlays.default
    # inputs.cells.lib.__inputs__.poe
  ];
}
