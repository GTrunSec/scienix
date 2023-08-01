{ inputs, cell }:
{
  nushell = inputs.nixpkgs-master.legacyPackages.nushell.overrideAttrs (
    old: {
      cargoBuildFlags = [
        "--features"
        "dataframe"
      ];
    }
  );
}
