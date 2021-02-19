{
  description = "Nubank overlay for Nixpkgs";

  outputs = { self }: { overlay = import ./default.nix; };
}
