{
  description = "Herd7";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.herd7 =
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    pkgs.stdenv.mkDerivation rec {
      name = "herd7";
      src = self;
      nativeBuildInputs = with pkgs; [
        ];
      buildInputs = with pkgs; [
        which
        ocaml
        ocamlPackages.findlib
        ocamlPackages.menhir
        ocamlPackages.menhirLib
        ocamlPackages.zarith
        dune_3

        ];
      buildPhase = ''
        mkdir -p $out;
        make PREFIX=$out all;
      '';
      installPhase = ''
        make PREFIX=$out install
      '';
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.herd7;

  };
}
