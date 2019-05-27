
# Nix utility to extract scripts from markdown documents

## How to include

```nix
{
    nix-markdown-snippets = import (builtins.fetchGit {
        url = "https://github.com/fghibellini/nix-markdown-snippets.git";
        ref = "master";
        rev = "94697784cea3f657718da174e081da70066429ea";
    });

    nixpkgs = import <nixpkgs> { overlays = [ nix-markdown-snippets ]; };

    # send-random-order is a path pointing to a bash script
    send-random-order = nixpkgs.extract-snippet "send-random-order" { pattern = "curl"; path = ../docs/QUICKSTART.md; };
}
```

## Example usage

Extract only fenced code block from markdown document (the first argument is the name used in the store paths):

```nix
extract-snippet "send-random-order" { path = ../docs/QUICKSTART.md; };
```

Extract only the code block matching a grep pattern:

```nix
extract-snippet "send-random-order" { path = ../docs/QUICKSTART.md; pattern = "curl.*-XPOST"; };
```

Pipe the extracted code block through a filter command:

```nix
extract-snippet "send-random-order" { path = ../docs/QUICKSTART.md; filter = '' sed 's/10\.0\.0\.1:3920/localhost:9000/' ''; };
```
