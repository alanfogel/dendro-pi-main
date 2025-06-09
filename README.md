# 🌲 Dendro-Pi Monitoring System

This project sets up a Raspberry Pi to monitor dendrometers and take periodic images, then uploads data to Dropbox for long-term analysis at research sites.

---

## ⚙️ Initial Setup: Flashing the Pi SD Card

1. Insert SD card into your computer.
2. Download and open [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
3. Configure with the following:
   - **Device**: Raspberry Pi Zero
   - **OS**: Raspberry Pi OS 32-bit (Bookworm)
   - **Storage**: Select Storage (Mass Storage Device USB Device)
   - **Hostname**: e.g., `Dorval-8`
   - **Username/Password** (To log into the Pi): `madlab` / `______`
   - **Wi-Fi SSID/Password**: `new_aspen_2022` / `___________`
   - **Country**: CA
   - **Enable SSH**: Use password authentication
4. Save
    - Apply OS Customization Settings: Yes

5. When done, insert the SD card into your Pi and power it up.

---

## 🔌 Connect & Configure the Raspberry Pi

1. Connect your laptop to the same Wi-Fi as the Pi.
2. Open terminal (or PowerShell) and SSH into your Pi:
   ```bash
   ssh madlab@Dorval-8.local # ssh username@{hostname}.local
3. Run:
    ```bash
    sudo raspi-config
    ```
    - Set timezone under Localization
    - Reboot the Pi
4. After reboot, SSH in again and test the camera:
   ```bash
   raspicam -o test.jpg
   ```
   - If not found, install:
   ```bash
    sudo apt-get update
    sudo apt-get install python-picamera2 python3-picamera2
   ``` 

## 📦 Installing dendro-pi Scripts

1. Clone the project (eventually this repo):
````bash
git clone https://github.com/YOUR-ORG/dendro-pi-main.git
cd dendro-pi-main
````
2. Enter test folder and try:
```bash
cd test
python test_dendro.py
```
3. Edit your camera name in main/dendro_pictures.py on this line: ```CAMERA_NAME = "ADD NAME HERE"```
- (Replace `Dorval-8_` with your camera name):
```python
CAMERA_NAME = "Dorval-8_" # the trailing underscore is important for namining the files
```

## ☁️ Configure Dropbox Upload

1. In the root project directory ```~/dendro-pi-main/```:
```bash
git clone https://github.com/andreafabrizi/Dropbox-Uploader.git
cd Dropbox-Uploader
sudo chmod +x dropbox_uploader.sh
./dropbox_uploader.sh
```
- At the end of the output of the above command, it will ask for the “App key”
- Go to the Dropbox app developer url and login with your Dropbox account, a screen will appear having a “Create an app” button, and a list of Apps created with your account. Select “DendroPictures”
-	Under the settings tab - Scroll down and you will find the “App key” and “App secret”, note down them and return back to the terminal
-	In the terminal enter the codes when promted, (when you enter the “App secret”, then it will give you a link, visiting it, you will get the “Access code”), once all the information is provided you will link with your dropbox cloud.

Use:
- Email: Mad.lab.usask@gmail.com
- Password: __________

2. Update upload-to-dropbox.sh:
```bash
nano upload-to-dropbox.sh
```
Modify the upload line (Replace `Dorval-8` with your Dropbox folder name):
```bash
./dropbox_uploader.sh upload ~/dendro-pi-main/pictures/* /Dorval-8/ | grep "file exists with the same hash" > already_uploaded.txt
```

3. Ensure UNIX line endings:
```bash
dos2unix upload-to-dropbox.sh
```


## 🕓 Setup Crontab
1. Open crontab and save immediately:
```bash
crontab -e
```

2. If it's not empty, run:
```bash
crontab -r
```
3. Install scheduled jobs:
```bash
sh add_cron.sh
```
4. Confirm:
```bash
crontab -l
```

## ✅ Test Setup
```bash
# Take a picture
cd main
python dendro_pictures.py

# Upload pictures
cd ..
sh upload-to-dropbox.sh
```
- Check Dropbox for uploaded files.


## 📁 Copying Pictures from Pi to PC

From your Windows machine:

```powershell
scp -r madlab@Dorval8.local:~/dendro-pi-main/pictures C:\Users\alanj\Desktop
```
- Replace `Dorval8.local` with your Pi's hostname.
- Replace `C:\Users\alanj\Desktop` with your desired local directory.