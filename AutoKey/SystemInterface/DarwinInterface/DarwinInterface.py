import subprocess

def Darwin_MessageBox(message, title):
    try:
        script = f'''
            osascript -e 'display dialog "{message}" with title "{title}" buttons {{"OK"}} default button "OK"'
            '''
        subprocess.run(script, shell=True)
    except Exception as e:
        raise e

def Darwin_InputBox(prompt, title):
    try:
        script = f'''
            tell application "System Events"
                set user_input to display dialog "{prompt}" with title "{title}" default answer ""
                return text returned of user_input
            end tell
        '''
        result = subprocess.run(['osascript', '-e', script], capture_output=True, text=True)
        return result.stdout.strip()
    except Exception as e:
        raise e
