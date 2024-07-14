import ctypes
import ctypes.wintypes

def Windows_MessageBox(text, title):
    MessageBox = ctypes.windll.user32.MessageBoxW
    MessageBox(None, message, title, 0)

def Windows_InputBox():
    return

def Windows_WinGetTitle():
    user32 = ctypes.windll.user32
    length = user32.GetWindowTextLengthW(user32.GetForegroundWindow())
    buf = ctypes.create_unicode_buffer(length + 1)
    user32.GetWindowTextW(user32.GetForegroundWindow(), buf, length + 1)
    return buf.value

