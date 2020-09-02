# Nubank overlay for Nixpkgs

## Contents of the overlay

### `dart` and `flutter`

Pinned version of Dart/Flutter used in Nubank. Should be used together.

### `flutter-patch`

It is an alternative to `dart`/`flutter` above. This script patches a vanilla
Flutter SDK installation. Just use it like this:

```shell
flutter-patch $FLUTTER_ROOT
```

Keep in mind that using this script is kind trick. That is because Flutter SDK
downloads some binaries afterwards. Everytime Flutter downloads some binaries
you need to rerun this script. You will see strange problems otherwise (i.e.:
`flutter` commands failing to run or `no such file or directory` errors).

So using `dart`/`flutter` packages is **recommended** and this script should
be used as a last resort.

### `hover`

[Hover](https://github.com/go-flutter-desktop/hover) allows running Flutter
apps in desktop.

This package for now it is impure. It builds some Go dependencies at runtime,
including `go-flutter` (that is a C dependency). If you have issues with
linking phase, delete the following files:

```shell
rm -rf `go env GOPATH`
rm -rf `go env GOCACHE`
```

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

Afterwards, just add this to your `/etc/configuration.nix`:

```nix
{
  # ...
  environment.systemPackages = with pkgs; [
    nubank.flutter
    nubank.dart
    nubank.hover
  ];
  # ...
}
```

## Testing local

You can test your new/updated derivation updating the `shell.nix`, you just
need to update the `buildInputs` with the derivation you want to build then
run:

```bash
nix-shell
```

With that you will have a shell with your built derivation.

Also, using `nix-shell --pure` allows you to test just your derivation without
your system packages, making it easier to debug issues.
