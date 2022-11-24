{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  inherit (cell.lib.nixpkgs.python3Packages) polars;

  mkPoetryEnv =
    cell.lib.nixpkgs.poetry2nix.mkPoetryEnv
    (builtins.removeAttrs cell.lib.poetryPackages ["pkgs"]);

  mkPythonEnv =
    cell.lib.nixpkgs.python3.buildEnv.override
    {
      # extraLibs = inputs.cells.python.lib.poetryPackages.extraPackages nixpkgs.python3Packages;
      extraLibs = with cell.lib.nixpkgs.python3Packages; [
        polars
      ];
      # not recommended
      # ignoreCollisions = true;
    };

  mkMachEnv = cell.lib.nixpkgs.machlib.mkPython {
    requirements = ''
      numpy
      pandas
      polars
    '';
    overridesPre = [
      (
        self: super: {
          inherit
            (cell.lib.nixpkgs)
            polars
            ;
        }
      )
    ];
    packagesExtra = [];
    python = "python3";
    providers = {};
  };
}
