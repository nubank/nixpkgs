# Nubank overlay for Nixpkgs

## Contents of the overlay

### dart-nubank and flutter-nubank
Pinned version of Dart/Flutter used in Nubank. Should be used together.

## Usage of the overlay

### Latest master each rebuild
One way, and probably the most convenient way to pull in this overlay is by
just fetching the tarball of latest master on rebuild.

This has side-effects if packages breaks or things like that you may want
to be in control of which revision of the overlay you run.

```nix
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nubank/nixpkgs/archive/master.tar.gz;
    }))
  ];
}
```
