import subprocess

def Darwin_MessageBox(message, title):
    try:
        script = f'''
            osascript -e 'display dialog "{message}" with title "{title}" buttons {{"OK"}} default button "OK"'
            '''
        subprocess.run(script, shell=True)
    except Exception as e:
        print(f"An error occurred")
