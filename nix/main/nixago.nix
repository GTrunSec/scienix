{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  mdbook = std.std.nixago.mdbook {
    configData = {
      book.title = "Data Science Threat Intelligence Book";
    };
  };
}
