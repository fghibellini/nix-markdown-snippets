
# Nix utility to extract scripts from markdown documents

This [Nixpkgs](https://nixos.org/nixpkgs/) overlay adds a `fcbScript` function (fcb stands for **F**enced **C**ode **B**lock).

## How to include

`example.nix`:

```nix
rec {

    nix-markdown-snippets = import (builtins.fetchGit {
        url = "https://github.com/fghibellini/nix-markdown-snippets.git";
        ref = "master";
        rev = "61bf47290d1799ff85da1209e2e83dbc012b3588";
    });

    nixpkgs = import <nixpkgs> { overlays = [ nix-markdown-snippets ]; };

    send-random-order = nixpkgs.fcbScript "send-random-order" { path = ./QUICKSTART.md; pattern = "curl"; };

}
```

`QUICKSTART.md`:

````markdown
# Welcome!

This is how you create an order:
```
curl -XPOST http://custom.service.lolz/sendOrder
```
````

```bash
$ nix-build -A send-random-order example.nix
building '/nix/store/smilp4ia1s4sj9dzjixkr0yjr7mhz7hj-send-random-order-src.drv'...
these derivations will be built:
  /nix/store/abqmc5n2rjqipxxqaykivjr8wrljd6r2-send-random-order.drv
building '/nix/store/abqmc5n2rjqipxxqaykivjr8wrljd6r2-send-random-order.drv'...
/nix/store/ymjpfnjs5ja8faiy2igf2k7pjw1ga7v5-send-random-order
$ cat /nix/store/ymjpfnjs5ja8faiy2igf2k7pjw1ga7v5-send-random-order
curl -XPOST http://custom.service.lolz/sendOrder
```

## API

Extract only fenced code block from markdown document (the first argument is the name used in the store paths):

```nix
fcbScript "send-random-order" { path = ../docs/QUICKSTART.md; }
```

Extract only the code block matching a grep pattern:

```nix
fcbScript "send-random-order" { path = ../docs/QUICKSTART.md; pattern = "curl.*-XPOST"; }
```

Pipe the extracted code block through a filter command:

```nix
fcbScript "send-random-order" {
        path = ../docs/QUICKSTART.md;
        filter = ''
            sed 's/10\.0\.0\.1:3920/localhost:9000/'
        '';
    }
```
