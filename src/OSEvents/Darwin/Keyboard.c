#include "Autokey.h"
#include "Darwin.h"


void HandleKeyEvent(IOHIDEventStruct *event)
{
	
}

Modifiers GetModifiersFromFlag(uint32_t flags)
{
	Modifiers modifiers;

	modifiers.isShiftPressed = flags & NX_SHIFTMASK;
	modifiers.isCapsLockActive = flags & NX_ALPHASHIFTMASK;
	modifiers.isControlPressed = flags & NX_CONTROLMASK;
	modifiers.isOptionPressed = flags & NX_ALTERNATEMASK;
	modifiers.isCommandPressed = flags & NX_COMMANDMASK;

	modifiers.isLeftShiftPressed = flags & NX_DEVICELSHIFTKEYMASK;
	modifiers.isRightShiftPressed = flags & NX_DEVICERSHIFTKEYMASK;
	modifiers.isLeftControlPressed = flags & NX_DEVICELCTLKEYMASK;
	modifiers.isRightControlPressed = flags & NX_DEVICERCTLKEYMASK;
	modifiers.isLeftOptionPressed = flags & NX_DEVICELALTKEYMASK;
	modifiers.isRightOptionPressed = flags & NX_DEVICERALTKEYMASK;
	modifiers.isLeftCommandPressed = flags & NX_DEVICELCMDKEYMASK;
	modifiers.isRightCommandPressed = flags & NX_DEVICERCMDKEYMASK;

	return modifiers;

}

KeyEvent CreateKeyEvent(IOHIDEventStruct *event)
{
	KeyEvent keyEvent;
	keyEvent.keyCode = event->key;
	keyEvent.isKeyPressed = (event->type == NX_KEYDOWN);
	keyEvent.modifiers = GetModifiersFromFlag(event->flags);
	keyEvent.character = 
}
