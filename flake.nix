{
  description = "herd7";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "herd7";
      src = self;
      nativeBuildInputs = with pkgs; [
        which
        dune_3
        ocamlPackages.menhirLib
        ocamlPackages.menhir
        ocamlPackages.zarith
        ocamlPackages.findlib
        gnumake
        python3
        ];
      buildInputs = with pkgs; [
        ocaml
        ocamlPackages.ocaml-lsp
      ];
      postUnpack = ''
        export DUNE_CACHE=disabled;
      '';
      installPhase = ''
        ./dune-install.sh $out;
      '';
    };
  };
}
