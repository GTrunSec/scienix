{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
in
  {
    r ? (_: []),
    python ? (_: []),
    runtimeInputs ? (_: []),
    runtimeEnv ? (_: {}),
    text ? "",
  }: let
    pythonEnv =
      nixpkgs.python3.buildEnv.override
      {
        extraLibs = with nixpkgs.python3Packages;
          [
            nbconvert
            ipykernel
            jupyter
          ]
          ++ (python nixpkgs.python3Packages);
      };
    rEnv = nixpkgs.rWrapper.override {
      packages = with nixpkgs.rPackages;
        [rmarkdown]
        ++ (r nixpkgs.rPackages);
    };
  in
    writeShellApplication {
      name = "mkQuarto";
      runtimeInputs = [rEnv nixpkgs.quarto pythonEnv] ++ (runtimeInputs nixpkgs);
      runtimeEnv = {
        QUARTO_R = "${rEnv}/bin/R";
        QUARTO_PYTHON = "${pythonEnv}/bin/python";
      } // runtimeEnv (runtimeInputs nixpkgs);
      inherit text;
    }
