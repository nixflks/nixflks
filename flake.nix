{
  description = "A Nix-flake-based development environment";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      supportedSystems = nixpkgs.lib.systems.flakeExposed;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          function {
            # See: https://wiki.nixos.org/wiki/Overlays#In_a_Nix_flake
            pkgs = import nixpkgs {
              inherit system;

              overlays = [
                (final: previous: {

                })
              ];
            };

            inherit system;
          }
        );

      installNixPackages = pkgs: [
        pkgs.nix
        pkgs.nixd # Nix Language Server
      ];

      installNixFormatter = pkgs: pkgs.nixfmt-tree;
    in
    {
      formatter = forAllSystems ({ pkgs, ... }: installNixFormatter pkgs);

      devShells = forAllSystems (
        { pkgs, ... }:
        {
          default = pkgs.mkShellNoCC {
            packages = installNixPackages pkgs;
          };
        }
      );

      packages = forAllSystems (
        { pkgs, ... }:
        {
          default = pkgs.buildEnv {
            name = "profile";
            paths = installNixPackages pkgs;
          };

          bashbrew = pkgs.callPackage ./pkgs/bashbrew { };
          hacker-news-to-sqlite = pkgs.callPackage ./pkgs/hacker-news-to-sqlite { };
          paginate-json = pkgs.callPackage ./pkgs/paginate-json { };
        }
      );
    };
}
