#!/usr/bin/env bash

rm -rf thumbnails
mkdir thumbnails

echo "### Wallpapers" > README.md
echo "My current wallpaper rotation" >> README.md
echo "" >> README.md

for i in papes/*
do
    convert -resize 200x "$i" "${i/papes/thumbnails}"
    echo "[![${i/papes\//}](https://raw.githubusercontent.com/jonascarpay/Wallpapers/master/thumbnails${i/papes/})](https://raw.githubusercontent.com/jonascarpay/Wallpapers/master/$i)" >> README.md
done
