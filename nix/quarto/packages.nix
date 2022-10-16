{
  inputs,
  cell,
}: let
  inherit (inputs.cells._main.lib) __inputs__;
  inherit (__inputs__) vast2nix;
  inherit (inputs) nixpkgs;

  nixpkgs' = inputs.jupyterWith.inputs.nixpkgs.legacyPackages.${nixpkgs.system}.appendOverlays [
    inputs.jupyterWith.inputs.poetry2nix.overlay
    # inputs.cells.lib.__inputs__.poe
  ];
in {
  tenzir = nixpkgs.python3.buildEnv.override
    {
      extraLibs = with nixpkgs.python3Packages; [
        nbconvert
        ipykernel
        bash_kernel
        jupyter
      ];
    };
  # tenzir = nixpkgs'.poetry2nix.mkPoetryEnv {
  #   # projectDir = __inputs__.vast2nix.packages.${nixpkgs.system}.vast-latest.src + "/web";
  #   projectDir = ./.;
  #   overrides = nixpkgs'.poetry2nix.overrides.withDefaults (import ./overrides.nix);
  # };
}
