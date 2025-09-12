self: super:
let
  pkgSet = super.callPackage (super.fetchFromGitHub {
    owner = "sgroez";
    repo = "customNixPackages";
    rev = "3b9f986c57c53e03152a17964f7b5266f09ef45e";
    sha256 = "sha256-hash";
  }) {};
in
pkgSet

