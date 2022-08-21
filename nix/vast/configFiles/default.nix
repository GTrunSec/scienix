{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs vast2nix;
in {
  phishing-url-data-schema = nixpkgs.writeText "vast-phishing.data.schema" (import ./vast-phishing-data-schema.nix args);
  phishing-url-result-schema = nixpkgs.writeText "vast-phishing.url.schema" (import ./vast-phishing-result-schema.nix args);
}
