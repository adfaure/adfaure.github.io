{
  # nixos-22.05
  pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz){}
}:

let r_pkgs = with pkgs.rPackages;
  [
    knitr
    rmarkdown
    GA
    igraph
  ];
in
pkgs.mkShell {
  buildInputs = [
    pkgs.pandoc
    (pkgs.rWrapper.override {
      packages = r_pkgs;
    })
  ];
}
