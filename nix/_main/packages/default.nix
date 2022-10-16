{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  inherit
    (inputs.cells.julia.packages)
    julia-wrapped
    jnumpy
    ;
}
