{
  inputs,
  cell,
}: let
  inherit (cell.library) nixpkgs;
  inherit (inputs.cells.main.library) __inputs__;
in {
  julia-wrapped = nixpkgs.lib.julia-wrapped {
    package = nixpkgs.julia_18-bin;
    meta.mainProgram = "julia-bin";
    enable = {
      GR = true;
      python = inputs.cells.main.packages.poetryPython;
    };
    makeWrapperArgs = ["--add-flags" "-L''${./startup.jl}"];
  };
  jnumpy = cell.library.nixpkgs.python3Packages.callPackage ./jnumpy {inherit __inputs__;};
}
