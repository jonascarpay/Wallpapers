#!/usr/bin/env bash
# set -e

rm -rf thumbnails
mkdir thumbnails

thumb_url_root="https://raw.githubusercontent.com/jonascarpay/Wallpapers/master/thumbnails"
pape_url_root="https://raw.githubusercontent.com/jonascarpay/Wallpapers/master/papes"

echo "### Wallpapers" >README.md
echo "My current wallpaper rotation" >>README.md
echo "" >>README.md

n=$(ls papes/ | wc -l)
i=0

for src in papes/*; do
  ((i++))
  printf '%4d/%d: %s\n' "$i" "$n" "${src/papes\//}"

  trg="${src/papes/thumbnails}"

  convert -resize 200x "$src" "$trg"

  filename="$(basename "$src")"
  thumb_url="$thumb_url_root/$filename"
  pape_url="$pape_url_root/$filename"

  echo "[![$filename](${thumb_url// /%20})](${pape_url// /%20})" >>README.md
done
