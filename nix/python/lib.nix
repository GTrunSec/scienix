{
  inputs,
  cell,
}: {
  nixpkgs = inputs.dataflow2nix.prefect.lib.nixpkgs.appendOverlays [
    inputs.cells._automation.lib.__inputs__.nixpkgs-hardenedlinux.python.overlays.default
    inputs.cells._automation.lib.__inputs__.nixpkgs-hardenedlinux._common.lib.__modules__.rust-overlay.overlays.default

    (final: prev: {
      python3 =
        prev.python3.override
        (
          old: {
            packageOverrides =
              prev.lib.composeExtensions (old.packageOverrides or (_: _: {})) (selfPythonPackages: pythonPackages: let
              in {});
          }
        );
    })
  ];
}
