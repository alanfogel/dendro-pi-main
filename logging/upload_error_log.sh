#!/bin/bash
# Uploads the yearly error log to this Pi's Dropbox folder
YEAR=$(date +%Y)
LOG_FILE="/var/log/error-log_${YEAR}"
UPLOADER=~/Dropbox-Uploader/dropbox_uploader.sh
REMOTE_PATH="/$(hostname)/error-log_${YEAR}"   # e.g., /Dorval-Weather/error-log_2026

if [ -s "$LOG_FILE" ]; then
    $UPLOADER upload "$LOG_FILE" "$REMOTE_PATH"
fi