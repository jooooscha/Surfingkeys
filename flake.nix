{

  description = "";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      defaultPackage.${system} =
        pkgs.buildNpmPackage {
          pname = "kitingkeys";
          version = "0.1.0";
          src = ./.;
          npmDepsHash = "sha256-Z8YB7Z8S6J8rgIX1LBWPn/XVOKygQZWRiyJ5lHdt9tg=";

          PUPPETEER_SKIP_DOWNLOAD = true;

          # buildPhase = ''
            # npm install
            # npm run build
          # '';
        };




        # pkgs.stdenv.mkDerivation {
        #   name = "kitekeys";
        #   src = ./.;

        #   buildInputs = with pkgs; with nodePackages; [
        #     npm
        #     webpack
        #     webpack-cli
        #   ];

        #   buildPhase = ''
        #     npm run build:prod
        #   '';
        # };
    };
}
