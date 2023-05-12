#!/usr/bin/env bash
set -e

# Usage: ./make_gallery.sh
#
# Run in a directory with a "papes/" subdirectory, and it will create a
# "thumbnails/" subdirectory.
#
# Uses imagemagick's `convert`, so make sure that's installed.
# On Nix, nix-shell -p imagemagick --run ./make_gallery.sh

mv thumbnails thumbnails_old
mkdir thumbnails

url_root="https://raw.githubusercontent.com/jonascarpay/Wallpapers/master"

echo "### Wallpapers" >README.md
echo "My current wallpaper rotation" >>README.md
echo "" >>README.md

total=$(git ls-files papes/ | wc -l)

i=0

git ls-files papes/ -z | while read -d $'\0' src; do
	((i++)) || true
	filename="$(basename "$src")"
	printf '%4d/%d: %s... ' "$i" "$total" "$filename"

	target="${src/papes/thumbnails}"
	thumbnail_old="${src/papes/thumbnails_old}"
	if [[ ! -f "$thumbnail_old" ]]; then
		convert -resize 200x "$src" "$target"
		echo "converted!"
	else
		mv "$thumbnail_old" "$target"
		echo "skipped!"
	fi

	filename_escaped="${filename// /%20}"
	thumb_url="$url_root/thumbnails/$filename_escaped"
	pape_url="$url_root/papes/$filename_escaped"

	echo "[![$filename]($thumb_url)]($pape_url)" >>README.md
done

rm -rf thumbnails_old
