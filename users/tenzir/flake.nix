{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dc = {
      # url = "github:gtrunsec/data-science-threat-intelligence";
      url = "/home/gtrun/ghq/github.com/GTrunSec/data-science-threat-intelligence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    dc,
    ...
  } @ inputs: {
    # exec quarto command: nix run .#quarto.entrypoint index.qmd
    # enter devshell env: nix develop .#quarto.shell

    quarto = dc.x86_64-linux.quarto.lib.mkEnv {
      r = ps:
        with ps; [
          # add your custom R packages here
          ggplot2
        ];
      python = ps:
        with ps; [
          # add your custom Python packages here
          pandas
        ];
      text = ''
        quarto render "$@"
      '';
    };
  };
}
