#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Install Raycast Script
# @raycast.mode silent
# @raycast.packageName Copy script link to clipboard

#
# Optional parameters:
# @raycast.icon 📥
#
# Documentation:
# @raycast.description Install Raycast script from the web, to install copy the script link to clipboard and run the script via Raycast
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

link=$(pbpaste)
scripts_dir=#~/RaycastScripts ## IMPORTANT: Change this directory to your own scripts directory

if [ "$scripts_dir" == "" ]; then
    echo "Error: Scripts directory has not been set yet"
    exit 0
fi

t=$(which wget)
if [ -z "$t" ]; then
    echo "wget not found, install using brew install wget"
    exit 0
fi

echo "parsing link..."
link=${link/github.com/raw.githubusercontent.com}
link=${link/\/blob/""}
filename=${link##*/}

wget "$link" -P "$TMPDIR"

if grep -q '@raycast.title' "$TMPDIR/$filename"; then
    mv "$TMPDIR/$filename" "$scripts_dir"
    echo "Raycast script found and downloaded to scripts directory"
else
    rm "$TMPDIR/$filename"
    echo "No raycast script found!"
fi

