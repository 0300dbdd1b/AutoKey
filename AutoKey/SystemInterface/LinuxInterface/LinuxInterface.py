import subprocess

def Linux_MessageBox(text, title):
    try:
        script = f'''
            zenity --info --text {message} --title {title}
            '''
        subprocess.run(script, shell=True)
    except Exception as e:
        raise e

def Linux_InputBox(prompt, title):
    try:
        script = f'''
            zenity --entry --title {title} --text {prompt}
        '''
        result = subprocess.run(script, capture_output=True, text=True)
        return result.stdout.strip()
    except Exception as e:
        raise e
