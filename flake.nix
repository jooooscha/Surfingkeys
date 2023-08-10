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
          npmDepsHash = "sha256-nwtvcrUTACVZPbwYlSJhAEqRPgnEFy7D5PuDNs0HoLc=";

          PUPPETEER_SKIP_DOWNLOAD = true;
          browser = "firefox"; # env var for webpack

          buildPhase = ''
            npm install
            npm run build:prod
          '';

          installPhase = ''
            mkdir $out
            cp -r ./dist $out/dist
          '';
        };
    };
}
