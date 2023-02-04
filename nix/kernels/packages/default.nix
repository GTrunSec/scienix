{
  inputs,
  cell,
}: let
  inherit (inputs.jupyenv.lib.x86_64-linux) mkJupyterlabNew;
in {
  jupyenv = mkJupyterlabNew (import ./jupyenv.nix {inherit inputs cell;});
}
