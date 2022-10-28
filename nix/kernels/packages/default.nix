{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.jupyterWith.lib) mkKernel mkJupyterlab;
  __inputs__ = args // {inherit mkKernel nixpkgs;};
in {
  jupyterEnvironment = mkJupyterlab {
    jupyterlabEnvArgs.extraPackages = ps: [ps.jupytext];
    kernels = k: let
      i = __inputs__ // {kernels = k;};
    in [
      (import ./kernels/python.nix (i // {name = "python";}))
      (import ./kernels/julia.nix (i // {name = "julia";}))
      (import ./kernels/bash.nix (i // {name = "bash";}))
      # (import ./kernels/rust.nix (i // {name = "rust";}))
    ];
  };
}
