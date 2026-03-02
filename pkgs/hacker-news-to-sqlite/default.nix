{
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "hacker-news-to-sqlite";
  version = "0.4";
  format = "setuptools";

  src = python3Packages.fetchPypi {
    inherit pname version;

    # To get the source hash, first use a placeholder like `nixpkgs.lib.fakeHash`.
    # The build will fail, and the error message will show the correct hash.
    # ---------------------------------------------------------------------------
    # $ nix build '.#hacker-news-to-sqlite'
    # ---------------------------------------------------------------------------
    # sha256 = nixpkgs.lib.fakeHash;
    sha256 = "sha256-789CkO0uohYASiWQvruElU/GZ6GTMB9+ri640lFXaaI=";
  };

  propagatedBuildInputs = with python3Packages; [
    sqlite-utils
    click
    requests
    tqdm
  ];

  doCheck = false;
}
