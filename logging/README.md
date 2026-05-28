# Centralized Error & Event Logging

This folder installs a unified logging system for Raspberry Pi projects.  
It logs errors, Wi‑Fi changes, reboots, and other events to a yearly log file and automatically uploads it to Dropbox.

## What’s Installed

- **`pi-log`** – Command to append a timestamped event to `/var/log/error-log_YYYY`
- **Wi‑Fi monitor** – Logs every connect/disconnect (runs every minute via cron)
- **Hourly upload** – Uploads the yearly error log to `Dropbox/<hostname>/error-log_YYYY`
- **Cron jobs** – Reboot logging, Wi‑Fi check, and hourly upload

## Installation

Run this command **once** on the Pi:

```bash
cd ~/dendro-pi-main/logging
./install.sh
```

### The script will:
    Copy pi-log to /usr/local/bin
    Create the log file with proper permissions
    Copy helper scripts to ~/bin/
    Add cron jobs (preserves your existing crontab)
    Test the installation with a log entry

## Usage
    After installation, you can log any event from any script:

```bash
    pi-log "error" "Sensor read failed"
    pi-log "wifi" "Connection lost"
    pi-log "system" "Low voltage detected"
```

## From Python scripts
```python
    import subprocess
    subprocess.run(["pi-log", "camera", "Failed to capture image"])
```

## Files
    install.sh – One‑time setup script
    pi-log – The logging command
    check_wifi.sh – Wi‑Fi monitor (called by cron)
    upload_error_log.sh – Upload script (called by cron)

## Dropbox Integration
    The upload script uses $(hostname) as the target folder.
    Make sure your Dropbox has a folder matching the Pi’s hostname (e.g., Dorval-Weather).
    The log file will be saved as /YourPiName/error-log_2026.


### Viewing Logs Locally
```bash
    cat /var/log/error-log_2026
    tail -f /var/log/error-log_2026   # live monitoring
```
