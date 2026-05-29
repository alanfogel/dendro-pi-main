#!/bin/bash

PICTURES_DIR=~/dendro-pi-main/pictures
DROPBOX_PATH="/Dorval-8/"

# --- Upload pictures ---
cd ~/dendro-pi-main/Dropbox-Uploader
./dropbox_uploader.sh upload ~/dendro-pi-main/pictures/* "$DROPBOX_PATH" | grep "file exists with the same hash" > already_uploaded.txt

while IFS= read -r line; do
  FILENAME=$(echo "$line" | cut -d'"' -f 2)
  rm "$FILENAME"
done < already_uploaded.txt

# --- Log any upload failure (using unified logging) ---
# The dropbox_uploader.sh returns non-zero on failure
if [ $? -ne 0 ]; then
    /usr/local/bin/pi-log "error" "Picture upload failed"
fi