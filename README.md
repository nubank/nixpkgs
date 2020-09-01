# Nubank overlay for Nixpkgs

## Contents of the overlay

### `dart` and `flutter`

Pinned version of Dart/Flutter used in Nubank. Should be used together.

### `hover`

[Hover](https://github.com/go-flutter-desktop/hover) allows running Flutter
apps in desktop. For now it should be used with `flutter` package.

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
