# data-science-threat-intelligence

## Enter default shell Environment

```sh
direnv allow
nix develop

```

## Launch the JupyterLab Env with Nix

```bash
nix develop --command jupyterlab <IP> <PORT>
```

## Launch the Julia Pluto Notebook with Nix

```bash
nix develop --command pluto <IP> <PORT>
```

## Language Kernels and Environment

- [x] julia
  - add julia packages
  ```sh
  julia
  (data-science-threat-intelligence) pkg> add Arrow
  ```
- [x] rust
- [x] python
  - add python packages
  ```sh
  cd nix/python
  poetry add <name>
  ```
- [x] bash

## CLI workflow or commands runner

- [x] std TUI

```sh
std
# show all commands with fzf
std list | fzf
```

- [x] just

```sh
just <command>
```

- [x] cargo-make

```sh
td //vast/entrypoints/flow:run

[cargo-make] INFO - cargo make 0.36.0
[cargo-make] INFO - Build File: /nix/store/54h21jx7xazbikzafm7xqz7m6dvhm9if-cargo-make.toml
[cargo-make] INFO - Task: smtp-url
[cargo-make] INFO - Profile: development
[cargo-make] INFO - Running Task: legacy-migration
[cargo-make] INFO - Execute Command: "vast-integration" "-s" "./conf/vast/vast-integration.yaml" "-t" "SMTP log url"
```
