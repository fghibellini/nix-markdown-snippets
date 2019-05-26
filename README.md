
# Nix utility to extract scripts from markdown documents

## Example

```
send-random-order = extract-snippet { pattern = "curl.*-XPOST"; path = ../docs/QUICKSTART.md; filter = '' sed 's/10\.0\.0\.1:3920/localhost:9000/' ''; };
```
