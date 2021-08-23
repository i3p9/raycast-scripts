#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clipboard to Imgur
# @raycast.mode silent
# @raycast.packageName Uploads Copied Image or Image from Clipboard

#
# Optional parameters:
# @raycast.icon 📋
#
# Documentation:
# @raycast.description Upload Image from your Clipboard and copy the image link to clipboard
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

#pngpaste check
t=$(which pngpaste)
if [ -z "$t" ]; then
    echo "pngpaste not found, install using brew install pngpaste"
    exit -1
fi


###Client ID, use your own to avoid limits. Get from https://api.imgur.com/oauth2/addclient
client_id="6b1da49ab5fce27"

function upload {
	curl -s -H "Authorization: Client-ID $client_id" -H "Expect: " -F "image=$1" https://api.imgur.com/3/image.xml
}

#Grab full file path from clipboard if there's an image
file_img=$(osascript -e "POSIX path of (the clipboard as «class furl»)")
ext="${file_img##*.}"

case "$ext" in
    png|jpg|jpeg|gif) #If image file is found in cli
    echo "Image found"
    output=$(upload "@$file_img") 2>/dev/null
    ;;
    *)
    # check clipboard via pngpaste
    clip_img="$(mktemp).png"
    pngpaste "${clip_img}"
    output=$(upload "@$clip_img") 2>/dev/null
    ;;
esac

#Parse response from Imgur
if echo "$output" | grep -q 'success="0"'; then
    echo "From Imgur: Upload Error, try again" >&2
else
    url="${output##*<link>}"
    url="${url%%</link>*}"
    delete_hash="${output##*<deletehash>}"
    delete_hash="${delete_hash%%</deletehash>*}"

    echo -n "$url" | pbcopy
    jobdone=1
fi

#Error handlig is almost non-existent
if [ "$jobdone" -ne 1 ]; then
    echo "Upload Successful, link copied to clipboard"
else
    echo "No image/image file found in clipboard, try again."
fi
