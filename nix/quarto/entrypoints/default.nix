{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
in {
  example = cell.lib.mkEnv {
    r = ps:
      with ps; [
        # add your custom R packages here
        ggplot2
        dplyr
        ggplot2
        lubridate
        readr
        ggrepel
        tidyr
      ];
    python = ps:
      with ps; [
        # add your custom Python packages here
        pandas
        bash_kernel
      ];
    text = ''
      # write your custom bash script here
      # quarto render "$@"
    '';
  };
}
