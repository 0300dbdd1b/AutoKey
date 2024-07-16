#ifndef DARWIN_H
# define DARWIN_H
# include <ApplicationServices/ApplicationServices.h>

CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon);

#endif

