{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dc = {
      url = "github:gtrunsec/DeSci";
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
        # write your custom bash  here
        quarto render "$@"
      '';
    };
  };
}
