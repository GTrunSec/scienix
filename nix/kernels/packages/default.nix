{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.jupyterWith.lib) mkKernel mkJupyterlabInstance;
in {
  jupyterEnvironment = let
    inherit (builtins) map readDir attrNames;
    inherit (nixpkgs.lib.attrsets) filterAttrs;
    inherit (nixpkgs.lib.strings) hasPrefix hasSuffix;
    __inputs__ = inputs // {inherit mkKernel nixpkgs;};
  in
    mkJupyterlabInstance {
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
