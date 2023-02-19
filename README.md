# Raycast Scripts

### My collection of various Raycast scripts I've made to automate stuff

## `battery-info.sh`

Quick look at the battery related info. It shows in a line:

* Current Battery percentage
* Time remaining, (time to fully charged if plugged, time to depleate battery if on battery)
* Charging status, along with charger watts if charging
* Battery health percentage
* Battery total cycle
<img width="771" alt="image" src="https://user-images.githubusercontent.com/8825262/219951079-ac917aef-2772-4d64-b931-0acbdd5c5876.png">
<img width="769" alt="image" src="https://user-images.githubusercontent.com/8825262/219951277-3dd27ef5-c987-4287-adb3-38cd86997f8a.png">


## `clipboard-upload-to-imgur.sh`

It does two things:

1. You copy a image in Finder, run it and it uploads the image, copies link to clipboard
2. You have a image in clipboard (Eg. ⇧+⌃+⌘ +4, or copy an image from the web), run the script and it gets uploaded to Imgur, link gets copied to Clipboard

**Dependency:** `pngpaste`, grab it via `brew install pngpaste`

## `imgur-upload-latest-screenshot.sh`

A very simple script to upload the latest screenshot you have to Imgur and copy the uploaded image link to clipboard.

Instruction: Grab the `last2imgur.sh` from the repo and put it in your Raycast Scripts folder. That should be all.

## `screenshot-and-imgur.sh`

Launches the native screenshot interface selection, when done, uploads the image to Imgur, copies link to clipboard.

Notes: When you run it for the first time, Raycast will ask for screensharing permission, after giving the permission, it'll start working from the second time and onwards.

## `install-script.sh`

Simple script to install Raycast script from the internet. Simple copy the link to the script, and launch this script and after making sure its a valid Raycast Script, it'll be saved to your Scripts folder.

Note: Since there's no way to find which is *your* scripts folder, you have to manually edit the line in


![](https://i.imgur.com/ntskPP8.gif)
