import subprocess

def Linux_MessageBox(text, title):
    try:
        shellscript = f'''
            zenity --info --text {message} --title {title}
            '''
        subprocess.run(shellscript, shell=True)
    except FileNotFoundError:
        print("Zenity is required on Linux. Please install it using your package manager.")
