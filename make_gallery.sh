#!/usr/bin/env bash

rm -rf thumbnails
rm ~/Dropbox/Wallpapers/*
mkdir thumbnails

username="jonascarpay"

echo "### Wallpapers" > README.md
echo "My current wallpaper rotation" >> README.md
echo "" >> README.md

i=0

for p in papes/*
do
    ((i++))
    echo -e "$i\t${p/papes/}"

    # Create thumbnail
    convert -resize 200x "$p" "${p/papes/thumbnails}"
    # Make entry in README
    echo "[![${p/papes\//}](https://raw.githubusercontent.com/$username/Wallpapers/master/thumbnails${p/papes/})](https://raw.githubusercontent.com/$username/Wallpapers/master/$p)" >> README.md

    # Copy to Dropbox
    cp "$p" ~/Dropbox/Wallpapers/
done
