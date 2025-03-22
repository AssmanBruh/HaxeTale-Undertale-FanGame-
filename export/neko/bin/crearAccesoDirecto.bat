@echo off
set shell=WScript.CreateObject("WScript.Shell")
set shortcut=shell.CreateShortcut("C:\Users\cybertel\Desktop\UNDERTALE: GREEN.lnk")
shortcut.TargetPath="C:\Users\cybertel\Desktop\games\undertaleGame\HaxeTale-Undertale-FanGame-\export\neko\bin/\UtGreen.exe"
shortcut.Save()
exit