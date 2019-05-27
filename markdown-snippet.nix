{ fetchFromGitHub, writeScript, runCommand, gawk, stdenv, utillinux, findutils, bash, gnused }:
let

    markdown-snippets = fetchFromGitHub {
        owner  = "fghibellini";
        repo   = "markdown-snippets";
        rev    = "d862bc7b0484b9547d897cb2427ba123498e0019";
        sha256 = "014pbzls39a8v4b6lnhc7178gnkf7ia7zl4kwnsnpsn24rq2pfq8";
    };

in
name:
{ path, pattern ? "." , filter ? "cat" }:
let

    script = writeScript "${name}" (builtins.readFile script-contents);

    script-contents = runCommand "${name}-src" { inherit pattern; buildInputs = [ gawk stdenv utillinux findutils bash gnused ]; } ''
        cd ${markdown-snippets}
        bash ./extract-matching-block.sh "$pattern" ${path} | ${gen-filter filter} > $out
    '';

    gen-filter = text: writeScript "${name}-filter" text;

in script
