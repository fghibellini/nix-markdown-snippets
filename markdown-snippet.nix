{ fetchFromGitHub, writeScript, runCommand, gawk, stdenv, utillinux, findutils, bash, gnused }:
name:
{ path, pattern ? "." , filter ? "cat" }:
let

    markdown-snippets = fetchFromGitHub {
        owner  = "fghibellini";
        repo   = "markdown-snippets";
        rev    = "cf6afee83925db13a49c13279222db0a0c2485eb";
        sha256 = "10429vhllwhd0jp35h3zldjgr0cg7r89pim6zkcmxcqyip7vvzx1";
    };

    script = writeScript "${name}" (builtins.readFile script-contents);

    script-contents = runCommand "${name}-src" { inherit pattern; buildInputs = [ gawk stdenv utillinux findutils bash gnused ]; } ''
        cd ${markdown-snippets}
        bash ./extract-matching-block.sh "$pattern" ${path} | ${gen-filter filter} > $out
    '';

    gen-filter = text: writeScript "${name}-filter" text;

in script
