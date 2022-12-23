{
  kernels,
  name,
  inputs,
  ...
}: let
in
  kernels.julia {
    displayName = name;
    pkgs = inputs.nixpkgs;
    ijuliaRev = "6TIq1";
    julia-bin = inputs.cells.julia.packages.julia-wrapped;
    activate = "Pkg.activate(joinpath(ENV[\"PRJ_ROOT\"], \"nix/julia/packages\"))";
  }
