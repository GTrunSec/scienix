{ inputs, cell }:
{
  nushell = inputs.nixpkgs.nushell.overrideAttrs (
    old: {
      cargoBuildFlags = [
        "--features"
        "dataframe"
      ];
    }
  );
}
