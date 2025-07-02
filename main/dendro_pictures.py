import os

from picamera2 import Picamera2, Preview
import time
from datetime import datetime

PICTURES_PATH = r"/home/madlab/dendro-pi-main/pictures/"
os.makedirs(PICTURES_PATH, exist_ok=True)
os.chdir(PICTURES_PATH)
CAMERA_NAME = "DorvalTest"  # Edit this to change name picture file

def get_filename():
    return CAMERA_NAME + get_date_and_time()

def get_date_and_time():
    return str(datetime.now().year) + "-" + \
        str(datetime.now().month) + "-" + \
        str(datetime.now().day) + "-" + \
        str(datetime.now().hour)

def take_picture():
    picam2 = Picamera2()

    # Let Picamera2 auto-select max resolution
    capture_config = picam2.create_still_configuration()
    picam2.configure(capture_config)

    picam2.start()
    time.sleep(2)

    file_name = get_filename()
    
    # Capture the file
    os.chdir(PICTURES_PATH)
    picam2.capture_file(file_name + ".jpeg")

    picam2.close()

if __name__ == '__main__':
    take_picture()
