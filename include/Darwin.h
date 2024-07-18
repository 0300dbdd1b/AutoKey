#ifndef DARWIN_H
# define DARWIN_H
# include <IOKit/hid/IOHIDManager.h>
# include <IOKit/hid/IOHIDUsageTables.h>
#include <stdint.h>
#include <IOKit/hidsystem/ev_keymap.h>
#include <IOKit/hidsystem/IOLLEvent.h>
#include <IOKit/IOKitLib.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct 
{
	bool isShiftPressed;
	bool isCapsLockActive;
	bool isControlPressed;
	bool isOptionPressed;
	bool isCommandPressed;

	bool isLeftShiftPressed;
	bool isRightShiftPressed;
	bool isLeftControlPressed;
	bool isRightControlPressed;
	bool isLeftOptionPressed;
	bool isRightOptionPressed;
	bool isLeftCommandPressed;
	bool isRightCommandPressed;
} Modifiers;

typedef struct
{
	uint16_t keyCode;
	bool	isKeyPressed;
	Modifiers	modifiers;
} KeyEvent;

KeyEvent CreateKeyEvent(IOHIDValueRef value);
#endif

