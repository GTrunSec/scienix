# data-science-threat-intelligence

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
    julia-bin 
    (data-science-threat-intelligence) pkg> add Arrow
    ```
- [x] rust
- [x] python
    - add python packages
    ```sh
    cd nix/python
    poetry add <name>
    ```
- [x] rust
