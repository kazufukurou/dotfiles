#!/usr/bin/python

import i3ipc
import threading
import time
import subprocess

ipc = i3ipc.Connection()
transparency_val = '0.8'
prev_focused = None
color1 = "#ffffff"
color2 = "#888888"

for window in ipc.get_tree():
    if window.focused:
        prev_focused = window
    else:
        window.command('opacity ' + transparency_val)

def on_window_focus(ipc, focused):
    global prev_focused
    if focused.container.id != prev_focused.id: # https://github.com/swaywm/sway/issues/2859
        focused.container.command('opacity 1')
        prev_focused.command('opacity ' + transparency_val)
        prev_focused = focused.container

ipc.on("window::focus", on_window_focus)

t = threading.Thread(target=ipc.main)
t.start()

print('{"version":1}')
print('[[],')
while True:
    title = prev_focused.name
    month = time.strftime("%b")
    day = time.strftime("%d")
    weekday = time.strftime("%a")
    hour_minute = time.strftime("%R")
    amixer = subprocess.check_output(['amixer', 'get', 'Master'])
    volume_level = amixer.decode('utf-8').split()[-3].strip('[]%')
    volume_state = amixer.decode('utf-8').split()[-1].strip('[]')
    volume_color = color1 if volume_state == "on" else color2
    print('[')
    print('{"full_text":"%s","color":"%s"},' %(title,color2), flush=True)
    print('{"full_text":"%s","color":"%s"},' %(volume_level,volume_color), flush=True)
    print('{"full_text":"%s","color":"%s"},' %(month,color2), flush=True)
    print('{"full_text":"%s","color":"%s"},' %(day,color1), flush=True)
    print('{"full_text":"%s","color":"%s"},' %(weekday,color2), flush=True)
    print('{"full_text":"%s","color":"%s"},' %(hour_minute, color1), flush=True)
    print('],')
    time.sleep(1)
