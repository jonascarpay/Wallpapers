#!/usr/bin/env bash
set -e

rm -rf thumbnails
mkdir thumbnails

username="jonascarpay"

cat readme_header.md > README.md
echo "" >> README.md

n=$(ls papes/ | wc -l)
i=0

for p in papes/*
do
    ((i++))
    printf '%4d/%d: %s\n' "$i" "$n" "${p/papes\//}"

    # Create thumbnail
    convert -resize 200x "$p" "${p/papes/thumbnails}"
    # Make entry in README
    echo "[![${p/papes\//}](https://raw.githubusercontent.com/$username/Wallpapers/master/thumbnails${p/papes/})](https://raw.githubusercontent.com/$username/Wallpapers/master/$p)" >> README.md
done

if [ -d "$HOME/Dropbox/Wallpapers" ]; then

  rm ~/Dropbox/Wallpapers/*

  for p in papes/*
  do
    cp "$p" ~/Dropbox/Wallpapers/
  done

fi
