{ poetry2nix, jnumpy }:
poetry2nix.mkPoetryApplication {
  projectDir = jnumpy;
  poetrylock = ./poetry.lock;
}
