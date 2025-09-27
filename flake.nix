{
  description = "Nix Flakes Collection.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    hacker-news-to-sqlite-flake = {
      url = "./pkgs/hacker-news-to-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    paginate-json-flake = {
      url = "./pkgs/paginate-json";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      hacker-news-to-sqlite-flake,
      paginate-json-flake,
      ...
    }:
    let
      supportedSystems = nixpkgs.lib.systems.flakeExposed;

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});

      installNixPackages = pkgs: [
        pkgs.nix
        pkgs.busybox
      ];

      installNixProfilePackages = pkgs: [
        pkgs.nixd # Nix Language Server
        pkgs.nixfmt-rfc-style # Nix Formatter
      ];

      installNixShellScripts = pkgs: [
        (pkgs.writeShellScriptBin "log" ''
          # If the third argument is explicitly 'break', print a leading newline.
          # The default is now 'nobreak'.
          if [ "''${3:-nobreak}" = "break" ]; then
            echo
          fi

          # Run the gum log command with the first two arguments.
          ${pkgs.gum}/bin/gum log --level "$1" "$2"

          # If the fourth argument is explicitly 'break', print a trailing newline.
          # The default is now 'nobreak'.
          if [ "''${4:-nobreak}" = "break" ]; then
            echo
          fi
        '')
      ];
    in
    {
      # Run: $ nix develop
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = (installNixPackages pkgs.${system}) ++ (installNixShellScripts pkgs.${system});
        };
      });

      packages = forAllSystems (system: {
        # Run: $ nix profile install
        default = pkgs.${system}.buildEnv {
          name = "profile";
          paths = (installNixPackages pkgs.${system}) ++ (installNixProfilePackages pkgs.${system});
        };

        # Packages [Flakes]
        hacker-news-to-sqlite = hacker-news-to-sqlite-flake.packages.${system}.hacker-news-to-sqlite;
        paginate-json = paginate-json-flake.packages.${system}.paginate-json;
      });
    };
}
