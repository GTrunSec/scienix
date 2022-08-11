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
      python =
        nixpkgs.python3.buildEnv.override
        {
          extraLibs = with nixpkgs.python3Packages; [pandas];
          ignoreCollisions = true;
        };
    };
    makeWrapperArgs = ["--add-flags" "-L''${./startup.jl}"];
  };
  jnumpy = cell.library.nixpkgs.callPackage ./jnumpy {inherit __inputs__;};
}
