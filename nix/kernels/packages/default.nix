{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.jupyterWith.lib) mkKernel mkJupyterlabInstance;
  __inputs__ = args // {inherit mkKernel nixpkgs;};

  pythonPackages = p: import ./pythonPackages.nix p args;
in {
  inherit pythonPackages;

  jupyterEnvironment = let
    inherit (builtins) map readDir attrNames;
    inherit (nixpkgs.lib.attrsets) filterAttrs;
    inherit (nixpkgs.lib.strings) hasPrefix hasSuffix;
  in
    mkJupyterlabInstance {
      extensions = e: [e."jupyterlab-manager"];
      kernels = kernels:
        builtins.listToAttrs (map (name: {
            name = nixpkgs.lib.removeSuffix ".nix" name;
            value = import ./kernels/${name} (__inputs__ // {inherit name kernels;});
          }) (attrNames
            (filterAttrs
              (n: v: v == "regular" && hasSuffix ".nix" n && !hasPrefix "_" n)
              (readDir ./kernels))));
    };
}
