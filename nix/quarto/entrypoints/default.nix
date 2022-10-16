{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
in {
  tenzir-web = let
    rEnv = nixpkgs.rWrapper.override {
      packages = with nixpkgs.rPackages;[
        dplyr
        ggplot2
        lubridate
        readr
        rmarkdown
        ggrepel
        tidyr
      ];
  };
  in
    writeShellApplication {
      name = "tenzir-web";
      runtimeInputs = [rEnv nixpkgs.quarto cell.packages.tenzir];
      runtimeEnv ={
        QUARTO_R = "${rEnv}/bin/R";
      };
      text = ''
      # ${rEnv}/bin/R
      quarto render "$@"
      '';
    };
}
