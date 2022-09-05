{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.jupyterWith.lib) mkKernel mkJupyterlabInstance mkJupyterlabEnvironmentFromPath;
  __inputs__ = args // {inherit mkKernel nixpkgs;};

  pythonPackages = p: import ./pythonPackages.nix p args;
in {
  inherit pythonPackages;

  jupyterEnvironment = mkJupyterlabInstance {
    kernels = k: let
      i = __inputs__ // {kernels = k;};
    in [
      (import ./kernels/ipython.nix (i // {name = "python";}))
      (import ./kernels/julia.nix (i // {name = "julia";}))
    ];
  };
}
