{ inputs, cell }:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [ cell.overlays.default ];
in
{
  inherit (nixpkgs) quarto;
  # tenzir = nixpkgs'.poetry2nix.mkPoetryEnv {
  #   # projectDir = __inputs__.vast2nix.packages.${nixpkgs.system}.vast-latest.src + "/web";
  #   projectDir = ./.;
  #   overrides = nixpkgs'.poetry2nix.overrides.withDefaults (import ./overrides.nix);
  # };
}
