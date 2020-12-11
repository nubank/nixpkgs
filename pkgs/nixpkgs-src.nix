{ fakeSha256 }:

builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/tarball/bee3fb885fa3476fc6cd5274b1600f80bc278e51";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = fakeSha256;
    sha256 = "0iza3wfmz6lwiw8n9hzp75mxfsklq2pa9y3pvyxycnqs2i42sxdp";
}
