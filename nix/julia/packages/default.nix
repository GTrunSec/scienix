{
  inputs,
  cell,
}: let
  inherit (cell.lib) nixpkgs;
  inherit (inputs.cells.common.lib) __inputs__;
in {
  julia-wrapped = nixpkgs.lib.julia-wrapped {
    package = nixpkgs.julia_18-bin;
    meta.mainProgram = "julia";
    enable = {
      GR = true;
      # python = inputs.cells._automation.packages.poetryPython;
    };
    makeWrapperArgs = ["--add-flags" "-L''${./startup.jl}"];
  };
  jnumpy = cell.lib.nixpkgs.python3Packages.callPackage ./jnumpy {inherit __inputs__;};
}
