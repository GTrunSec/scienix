{
  inputs,
  cell,
}: {
  inherit
    (inputs.cells.julia.packages)
    julia-wrapped
    jnumpy
    ;
}
