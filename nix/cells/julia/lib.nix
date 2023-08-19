{ inputs, cell }:
{
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.julia2nix.overlays.default
    cell.overlays.default
  ];
}
