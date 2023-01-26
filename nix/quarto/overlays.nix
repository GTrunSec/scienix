{
  inputs,
  cell,
}: {
  default = final: prev: {
    quarto = with prev;
      quarto.overrideAttrs (old: {
        src = let
          version = "1.3.129";
        in
          prev.fetchurl {
            url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-linux-amd64.tar.gz";
            sha256 = "sha256-U0j10sd7+dCqO2uO/h1Ss1neZ5jlo/i3tT8RaMEnvYw=";
          };
        preFixup = ''
          wrapProgram $out/bin/quarto \
            --prefix PATH : ${lib.makeBinPath [deno]} \
            --prefix QUARTO_PANDOC : ${pandoc}/bin/pandoc \
            --prefix QUARTO_ESBUILD : ${esbuild}/bin/esbuild \
            --prefix QUARTO_DART_SASS : ${nodePackages.sass}/bin/sass
        '';
      });
  };
}
