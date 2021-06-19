#!/usr/bin/env bash

mkdir -p $1

for aur_dir in */; do

    if [ "$aur_dir" == "$1/" ] ; then
            continue;
    fi

    (cd "$aur_dir" && makepkg -s && mv *.pkg.tar* "../$1")
done