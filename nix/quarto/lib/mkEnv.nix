{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
  l = inputs.nixpkgs.lib // builtins;
in
  {
    r ? (_: []),
    python ? (_: []),
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
      runtimeInputs = [rEnv nixpkgs.quarto pythonEnv];
      runtimeEnv = {
        QUARTO_R = "${rEnv}/bin/R";
        QUARTO_PYTHON = "${pythonEnv}/bin/python";
      };
      inherit text;
    }
