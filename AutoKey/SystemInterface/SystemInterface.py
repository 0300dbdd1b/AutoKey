import platform
from AutoKey.SystemInterface.DarwinInterface.DarwinInterface import *
from AutoKey.SystemInterface.WindowsInterface.WindowsInterface import *
from AutoKey.SystemInterface.LinuxInterface.LinuxInterface import *
OS_NAME = platform.system()

def MessageBox(text, title):
    if OS_NAME == 'Windows':
        Windows_MessageBox(text, title)
    elif OS_NAME == 'Linux':
        Linux_MessageBox(text, title)
    elif OS_NAME == 'Darwin':
        Darwin_MessageBox(text, title)
    else:
        raise ValueError("Unknown OS_NAME")

def InputBox(prompt, title):
    if OS_NAME == 'Windows':
        Linux_InputBox(prompt, title)
    elif OS_NAME == 'Linux':
        Linux_InputBox(prompt, title)
    elif OS_NAME == 'Darwin':
        Darwin_InputBox(prompt, title)
    else:
        raise ValueError("Unknown OS_NAME")
