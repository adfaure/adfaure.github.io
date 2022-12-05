{
  inputs = {
    oxalica.url = "github:oxalica/rust-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    kodama-theme.url = "github:adfaure/kodama-theme";
  };

  outputs = { self, nixpkgs, oxalica, kodama-theme }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ oxalica.overlay ];
        config.allowUnfree = true;
      };
    in {

      packages.x86_64-linux = {
        website = pkgs.stdenv.mkDerivation rec {
          version = "0.0.1";
          name = "website-${version}";
          src = self;

          buildInputs = [
            pkgs.zola
            pkgs.nodePackages.npm
            kodama-theme.packages.x86_64-linux.website
          ];

          checkPhase = ''
            zola check
          '';

          buildPhase = ''
            export theme_folder="themes/kodama-theme"
            cp -rL --no-preserve=mode ${kodama-theme} $theme_folder
            cp $theme_folder/styles/styles.css styles/styles.css
          '';

          base-url = "https://a-t-richard.github.io";

          installPhase = ''
            zola build -o $out --base-url ${base-url}
          '';
        };

        # Package for github-page
        ghp = self.packages.x86_64-linux.website.overrideAttrs (old: rec {
          base-url = "https://a-t-richard.github.io";
          installPhase = "zola build -o $out --base-url ${base-url}";
        });

      };
      # Use `nix develop` to activate the shell
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          zola
          nodePackages.npm
          nodePackages.node2nix
        ];
        # This tells npx where to find the node lib.
        # The css generation can be done with:
        # npx tailwindcss -i styles/styles.css -o static/styles/styles.css
        # NODE_PATH="${nodeDependencies}/lib/node_modules";
      };
    };
}
