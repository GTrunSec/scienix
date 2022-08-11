{
  poetry2nix,
  __inputs__,
}:
poetry2nix.mkPoetryApplication {
  projectDir = __inputs__.jnumpy;
  poetrylock = ./poetry.lock;
}
