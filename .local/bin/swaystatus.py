#!/usr/bin/python

import sys
import time
import json
import i3ipc
import threading
import subprocess

ipc = i3ipc.Connection()
color1 = sys.argv[1]
color2 = sys.argv[2]
transparency_val = '0.75'
prev_focused = None

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

def print_status(text, highlight):
    color = color1 if highlight else color2
    print('{"full_text":%s,"color":"#%s"},' %(json.dumps(text), color), flush = True)

ipc.on("window::focus", on_window_focus)
t = threading.Thread(target=ipc.main)
t.start()

print('{"version":1}')
print('[[],')
while True:
    amixer = subprocess.check_output(['amixer', 'get', 'Master'])
    volume_level = amixer.decode('utf-8').split()[-3].strip('[]%')
    volume_state = amixer.decode('utf-8').split()[-1].strip('[]')
    print('[')
    print_status(prev_focused.name, False)
    print_status(' ', False)
    print_status('V', False)
    print_status(volume_level, volume_state == 'on')
    print_status(' ', False)
    print_status(time.strftime('%b'), False)
    print_status(time.strftime('%d'), True)
    print_status(time.strftime('%a'), False)
    print_status(time.strftime('%R'), True)
    print('],')
    time.sleep(1)
