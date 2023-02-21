{
  inputs,
  cell,
}: {
  quarto = import ./quarto.nix {inherit inputs cell;};
}
