
# Nix utility to extract scripts from markdown documents

This [Nixpkgs](https://nixos.org/nixpkgs/) overlay adds a `fcbScript` function (fcb stands for **F**enced **C**ode **B**lock).

## How to include

```nix
rec {

    nix-markdown-snippets = import (builtins.fetchGit {
        url = "https://github.com/fghibellini/nix-markdown-snippets.git";
        ref = "master";
        rev = "02f17250f8a2a6496448b910e33b9ce59942aa1c";
    });

    nixpkgs = import <nixpkgs> { overlays = [ nix-markdown-snippets ]; };

    send-random-order = nixpkgs.fcbScript "send-random-order" { path = ./QUICKSTART.md; pattern = "curl"; };

}
```

## Example usage

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
