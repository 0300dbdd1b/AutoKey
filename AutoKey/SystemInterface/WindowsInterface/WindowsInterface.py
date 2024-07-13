import ctypes

def Windows_MessageBox(text, title):
    MessageBox = ctypes.windll.user32.MessageBoxW
    MessageBox(None, message, title, 0)
