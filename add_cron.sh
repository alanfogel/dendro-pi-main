#!/bin/bash

crontab -l 2>/dev/null > temp_cron || true

cat <<EOF >> temp_cron
# Take a picture every hour
0 * * * * /usr/bin/python3 /home/madlab/dendro-pi-main/main/dendro_pictures.py

# Upload pictures to Dropbox once per day at 3am
0 3 * * * bash /home/madlab/dendro-pi-main/upload-to-dropbox.sh
EOF

crontab temp_cron
rm temp_cron

echo "Crontab installed."
