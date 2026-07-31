#!/bin/bash

README="README.md"

rm -f "$README"

# Count all emoji image files
FILECOUNT=$(find ./emojis -type f \
  \( -iname "*.webp" -o -iname "*.gif" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
  | wc -l | tr -d ' ')

echo "# Emoji Collection" >> "$README"
echo "" >> "$README"
echo "A collection of emojis for easy access in the future ." >> "$README"
echo "" >> "$README"
echo "**$FILECOUNT emojis**" >> "$README"
echo "" >> "$README"
echo "This README was generated using \`./generate-readme.sh\`." >> "$README"
echo "" >> "$README"

# Go through each theme folder
for theme in ./emojis/*/; do

  theme_name="${theme#./emojis/}"
  theme_name="${theme_name%/}"

  echo "## $theme_name" >> "$README"
  echo "" >> "$README"

  echo "| Emoji preview | Emoji name |" >> "$README"
  echo "| --- | --- |" >> "$README"

  # Find images and sort them alphabetically
  find "$theme" -maxdepth 1 -type f \
    \( -iname "*.webp" -o -iname "*.gif" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
    | sort -f \
    | while IFS= read -r filename; do

      name=$(basename "$filename")

      echo "| <img src='$filename' width='96'> | $name |" >> "$README"

    done

  echo "" >> "$README"

done

echo "README generated: $FILECOUNT emojis."