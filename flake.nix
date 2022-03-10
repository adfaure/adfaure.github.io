{
  inputs = {
    oxalica.url = "github:oxalica/rust-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, oxalica }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ oxalica.overlay ];
        config.allowUnfree = true;
      };
    in {

      packages.x86_64-linux = {
        website = pkgs.stdenv.mkDerivation rec {
          version = "0.0.1";
          name = "batsite-${version}";
          src = pkgs.lib.sourceByRegex ./. [
            "^content"
            "^content/.*\.md"
            "^static"
            "^static/.*"
            "^templates"
            "^templates/.*"
            "^themes"
            "^themes/.*"
            "^sass/.*"
            "^sass/.*\.scss"
            "config.toml"
          ];
          base-url = "https://batsim.org";
          buildInputs = [ pkgs.zola ];
          checkPhase = ''
            zola check
          '';
          installPhase = ''
            zola build -o $out --base-url ${base-url}
          '';
        };
      };
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          zola
        ];
        shellHook = "zsh; exit 0";
      };
    };
}
