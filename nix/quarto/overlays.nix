{
  inputs,
  cell,
}: {
  default = final: prev: {
    quarto = with prev;
      quarto.overrideAttrs (old: rec {
        version = "1.3.154";
        src = prev.fetchurl {
          url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-linux-amd64.tar.gz";
          sha256 = "sha256-78gtI/8+RDE8Agy1Go5FkA70gyTzBZ7ssA/Z22OOTj8=";
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
