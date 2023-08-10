{

  description = "";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      version = "0.2.0";
    in {
      defaultPackage.${system} =
        pkgs.buildNpmPackage {
          inherit version;
          pname = "kitingkeys";
          src = ./.;
          npmDepsHash = "sha256-nwtvcrUTACVZPbwYlSJhAEqRPgnEFy7D5PuDNs0HoLc=";

          PUPPETEER_SKIP_DOWNLOAD = true;
          browser = "firefox"; # env var for webpack

          configurePhase = ''
            sed -i '3i\  "version": "${version}",' package.json
          '';

          buildPhase = ''
            npm install
            npm run build
          '';

          installPhase = ''
            mkdir $out
            cp -r ./dist $out/dist
          '';
        };
    };
}
