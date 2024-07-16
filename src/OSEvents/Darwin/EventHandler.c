#include "Darwin.h"

CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) 
{
    return event;
}
