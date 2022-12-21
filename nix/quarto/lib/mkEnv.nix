{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [cell.overlays.default];
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  l = inputs.nixpkgs.lib // builtins;
in
  {
    r ? (_: []),
    python ? (_: []),
    text ? "",
    runtimeInputs ? [],
  }: let
    pythonEnv = nixpkgs.python3.withPackages (ps:
      with ps;
        [
          jupyter
          ipython
        ]
        ++ (python ps));

    rEnv = nixpkgs.rWrapper.override {
      packages = with nixpkgs.rPackages;
        [rmarkdown]
        ++ (r nixpkgs.rPackages);
    };
  in
    writeShellApplication {
      name = "mkQuarto";
      runtimeInputs =
        [
          nixpkgs.quarto
        ]
        ++ runtimeInputs;
      runtimeEnv = {
        QUARTO_R = "${rEnv}/bin/R";
        QUARTO_PYTHON = "${pythonEnv}/bin/python3";
      };
      inherit text;
    }
