{ inputs, cell }:
let
  inherit (cell.lib) nixpkgs;
in
{
  julia-wrapped = nixpkgs.lib.julia-wrapped {
    package = nixpkgs.julia;
    meta.mainProgram = "julia";
    enable = {
      GR = true;
      # python = inputs.cells.automation.packages.poetryPython;
    };
    makeWrapperArgs = [
      "--add-flags"
      "-L''${./startup.jl}"
    ];
  };
  jnumpy = cell.lib.nixpkgs.python3Packages.callPackage ./jnumpy {
    inherit (inputs) jnumpy;
  };

  juliaEnv = nixpkgs.lib.buildEnv {
    src = ./.;
    name = "juliaEnv";
    package = cell.packages.julia-wrapped;
  };
}
