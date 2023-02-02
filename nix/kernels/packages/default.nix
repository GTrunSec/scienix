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
      (import ./kernels/python.nix (i // {name = "pythonKernel";}))
      (import ./kernels/julia.nix (i // {name = "juliaKernel";}))
      (import ./kernels/bash.nix (i // {name = "bashKernel";}))
      # (import ./kernels/rust.nix (i // {name = "rustWith";}))
    ];
  };
}
