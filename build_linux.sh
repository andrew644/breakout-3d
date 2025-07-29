#!/usr/bin/env bash -eu

OUT="out/linux"
mkdir -p $OUT
odin build src/linux -out:$OUT/game
cp -R ./assets/ ./$OUT/assets/
echo "Build successful"
