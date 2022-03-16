#!/usr/bin/env bash

source $stdenv/setup
PATH=$dpkg/bin:$PATH

dpkg -x $src unpacked

cp -r unpacked/* $out/
