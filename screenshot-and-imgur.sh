#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screenshot and Imgur
# @raycast.mode silent
# @raycast.packageName Opens screenshot mode

#
# Optional parameters:
# @raycast.icon 📷
#
# Documentation:
# @raycast.description bla bla
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

client_id="6b1da49ab5fce27"

function upload {
	curl -s -H "Authorization: Client-ID $client_id" -H "Expect: " -F "image=$1" https://api.imgur.com/3/image.xml
}

screencapture -c -s

clip_img="$(mktemp).png"
pngpaste "${clip_img}"
output=$(upload "@$clip_img") 2>/dev/null

if echo "$output" | grep -q 'success="0"'; then
    echo "From Imgur: Upload Error, try again" >&2
else
    url="${output##*<link>}"
    url="${url%%</link>*}"
    delete_hash="${output##*<deletehash>}"
    delete_hash="${delete_hash%%</deletehash>*}"

    echo -n "$url" | pbcopy
    echo "Upload Successful, link copied to clipboard"
fi
