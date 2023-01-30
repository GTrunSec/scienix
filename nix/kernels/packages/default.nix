{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.jupyterWith.lib.x86_64-linux) mkJupyterlab;
  __inputs__ = args // {inherit nixpkgs;};
in {
  jupyterEnvironment = mkJupyterlab {
    jupyterlabEnvArgs.extraPackages = ps: [ps.jupytext];
    kernels = k: let
      i = __inputs__ // {kernels = k;};
    in [
      (import ./kernels/python.nix (i // {name = "pythonWith";}))
      (import ./kernels/julia.nix (i // {name = "juliaWith";}))
      (import ./kernels/bash.nix (i // {name = "bashWith";}))
      # (import ./kernels/rust.nix (i // {name = "rustWith";}))
    ];
  };
}
