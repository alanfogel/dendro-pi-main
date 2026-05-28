#!/bin/bash
# Monitors Wi‑Fi connection changes and logs them
STATUS_FILE=/tmp/wifi_status
CURRENT=$(/usr/sbin/iwgetid -r)   # adjust path if needed
[ -f "$STATUS_FILE" ] && OLD=$(cat "$STATUS_FILE") || OLD=""
if [ "$CURRENT" != "$OLD" ]; then
    if [ -n "$CURRENT" ]; then
        /usr/local/bin/pi-log "wifi" "Connected to $CURRENT"
    else
        /usr/local/bin/pi-log "wifi" "Disconnected"
    fi
    echo "$CURRENT" > "$STATUS_FILE"
fi