{
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "bashbrew";
  version = "0.1.13";

  src = fetchFromGitHub {
    owner = "docker-library";
    repo = "bashbrew";
    tag = "v${version}";

    # To get the source hash, first use a placeholder like `nixpkgs.lib.fakeHash`.
    # The build will fail, and the error message will show the correct hash.
    # ---------------------------------------------------------------------------
    # $ nix build '.#bashbrew'
    # ---------------------------------------------------------------------------
    # hash = nixpkgs.lib.fakeHash;
    hash = "sha256-pAFPO5DuEqLHI9ypG6qJacUr9bSUjxR6oGlRPRjDeQI=";
  };

  # After updating the source `hash`, run the build command again with a fake
  # `vendorHash`. The build will fail a second time, providing the correct
  # hash for the Go module dependencies.
  # ---------------------------------------------------------------------------
  # $ nix build '.#bashbrew'
  # ---------------------------------------------------------------------------
  # vendorHash = nixpkgs.lib.fakeHash;
  vendorHash = "sha256-elajlc+QuS+R0w7Pz15y3ElcDhIWH5wjdxZ+LsP1a6I=";

  doCheck = false;
}
