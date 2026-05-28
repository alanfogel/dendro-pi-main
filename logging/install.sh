#!/bin/bash
# Install central logging for a Pi
# Run as: ./install.sh

set -e  # exit on error

echo "Installing centralized error logging..."

# 1. Copy pi-log to /usr/local/bin
sudo cp pi-log /usr/local/bin/
sudo chmod +x /usr/local/bin/pi-log

# 2. Create log file and set ownership
sudo touch /var/log/error-log_$(date +%Y)
sudo chown $USER:$USER /var/log/error-log_$(date +%Y)

# 3. Create ~/bin if needed, and copy helper scripts
mkdir -p ~/bin
cp check_wifi.sh upload_error_log.sh ~/bin/
chmod +x ~/bin/check_wifi.sh ~/bin/upload_error_log.sh

# 4. Add cron jobs (idempotent – won't duplicate)
TEMP_CRON=$(mktemp)
crontab -l > "$TEMP_CRON" 2>/dev/null || true

# Define required cron lines
CRON_REBOOT="@reboot /usr/local/bin/pi-log \"system\" \"Power on / reboot\""
CRON_WIFI="* * * * * /home/$USER/bin/check_wifi.sh"
CRON_UPLOAD="0 * * * * /home/$USER/bin/upload_error_log.sh"

# Add if not already present
grep -F "$CRON_REBOOT" "$TEMP_CRON" || echo "$CRON_REBOOT" >> "$TEMP_CRON"
grep -F "$CRON_WIFI" "$TEMP_CRON" || echo "$CRON_WIFI" >> "$TEMP_CRON"
grep -F "$CRON_UPLOAD" "$TEMP_CRON" || echo "$CRON_UPLOAD" >> "$TEMP_CRON"

crontab "$TEMP_CRON"
rm "$TEMP_CRON"

# 5. Test the installation
echo "Testing pi-log..."
/usr/local/bin/pi-log "install" "Logging setup complete"

echo "Installation done. Check with: cat /var/log/error-log_$(date +%Y)"