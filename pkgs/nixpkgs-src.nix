{ fakeSha256 }:

builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/tarball/fef46b9281cfde685bfdea74572eae34b518d48e";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = fakeSha256;
    sha256 = "1cjn0i8zy145i2whdjxgk67smbh6jiq0snxps8cp061511vp3gz3";
}
