{
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "paginate-json";
  version = "1.0";
  format = "setuptools";

  src = python3Packages.fetchPypi {
    inherit pname version;

    # To get the source hash, first use a placeholder like `nixpkgs.lib.fakeHash`.
    # The build will fail, and the error message will show the correct hash.
    # ---------------------------------------------------------------------------
    # $ nix build '.#paginate-json'
    # ---------------------------------------------------------------------------
    # sha256 = nixpkgs.lib.fakeHash;
    sha256 = "sha256-aJ01mbOKMlxvSudsdzuMeab18yQwXKaojtG/cs68BPM=";
  };

  propagatedBuildInputs = with python3Packages; [
    click
    requests
  ];

  doCheck = false;
}
