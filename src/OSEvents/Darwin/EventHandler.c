#include "Darwin.h"


void handleKeyEvent(IOHIDEventStruct *event) {
    // Check if the event is a keyboard event
    if (event->type == NX_KEYDOWN || event->type == NX_KEYUP) {
        // Create the key event structure
        KeyEvent keyEvent = CreateKeyEvent(event);

        // Print the key event information
        printf("Key %s: (KeyCode: %u, Shift: %d, CapsLock: %d, Control: %d, Option: %d, Command: %d, LShift: %d, RShift: %d, LControl: %d, RControl: %d, LOption: %d, ROption: %d, LCommand: %d, RCommand: %d)\n",
               keyEvent.isKeyPressed ? "pressed" : "released",
               keyEvent.keyCode,
               keyEvent.modifiers.isShiftPressed,
               keyEvent.modifiers.isCapsLockActive,
               keyEvent.modifiers.isControlPressed,
               keyEvent.modifiers.isOptionPressed,
               keyEvent.modifiers.isCommandPressed,
               keyEvent.modifiers.isLeftShiftPressed,
               keyEvent.modifiers.isRightShiftPressed,
               keyEvent.modifiers.isLeftControlPressed,
               keyEvent.modifiers.isRightControlPressed,
               keyEvent.modifiers.isLeftOptionPressed,
               keyEvent.modifiers.isRightOptionPressed,
               keyEvent.modifiers.isLeftCommandPressed,
               keyEvent.modifiers.isRightCommandPressed);
    }
}

void MonitorEvents()
{

    IOHIDManagerRef manager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    if (CFGetTypeID(manager) != IOHIDManagerGetTypeID()) {
        printf("Failed to create HID manager.\n");
        return;
    }

    IOHIDManagerSetDeviceMatching(manager, NULL);
    IOHIDManagerRegisterInputValueCallback(manager, Handle_HID_Event, NULL);
    IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);

    IOReturn result = IOHIDManagerOpen(manager, kIOHIDOptionsTypeNone);
    if (result != kIOReturnSuccess) {
        printf("Failed to open HID manager.\n");
        CFRelease(manager);
        return;
    }

    CFRunLoopRun();

    IOHIDManagerClose(manager, kIOHIDOptionsTypeNone);
    CFRelease(manager);
}

void Handle_HID_Event(void* context, IOReturn result, void* sender, IOHIDValueRef value) {
    KeyEvent keyEvent = CreateKeyEvent(value);

    // Print the key event information
    printf("Key %s: (KeyCode: %u, Shift: %d, CapsLock: %d, Control: %d, Option: %d, Command: %d, LShift: %d, RShift: %d, LControl: %d, RControl: %d, LOption: %d, ROption: %d, LCommand: %d, RCommand: %d)\n",
           keyEvent.isKeyPressed ? "pressed" : "released",
           keyEvent.keyCode,
           keyEvent.modifiers.isShiftPressed,
           keyEvent.modifiers.isCapsLockActive,
           keyEvent.modifiers.isControlPressed,
           keyEvent.modifiers.isOptionPressed,
           keyEvent.modifiers.isCommandPressed,
           keyEvent.modifiers.isLeftShiftPressed,
           keyEvent.modifiers.isRightShiftPressed,
           keyEvent.modifiers.isLeftControlPressed,
           keyEvent.modifiers.isRightControlPressed,
           keyEvent.modifiers.isLeftOptionPressed,
           keyEvent.modifiers.isRightOptionPressed,
           keyEvent.modifiers.isLeftCommandPressed,
           keyEvent.modifiers.isRightCommandPressed);
}
