NAME = AutoKey

SRCDIR = src
INCDIR = include
OBJDIR = obj
BINDIR = bin
LIBDIR = lib

AKSCRIPTDIR = AKScript
OSEVENTSDIR = OSEvents


INCLUDE_DIRS =	$(INCDIR) 			\
				$(INCDIR)/AKScript	\

INCLUDE_FLAGS = $(addprefix -I, $(INCLUDE_DIRS))


CFILES =	main.c									\
			$(OSEVENTSDIR)/Darwin/EventHandler.c	\
			$(OSEVENTSDIR)/Darwin/Keyboard.c		\
        	$(AKSCRIPTDIR)/Darwin/WinFunctions.c	\
        	$(AKSCRIPTDIR)/Linux/WinFunctions.c     \
        	$(AKSCRIPTDIR)/Windows/WinFunctions.c	

SRCS = $(addprefix $(SRCDIR)/, $(CFILES))

OBJS = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS))

EXEC = $(BINDIR)/$(NAME)

CC = gcc
CFLAGS = -Wall -Wextra $(INCLUDE_FLAGS)
LDFLAGS = -lm -ldl -lpthread

all: detect_os

detect_os:
	@uname_out=$$(uname -s) || exit 1; \
	case $${uname_out} in \
		Darwin*)  $(MAKE) DARWIN_BUILD ;; \
		Linux*)   $(MAKE) LINUX_BUILD ;; \
		MINGW* | MSYS* | CYGWIN*) $(MAKE) WINDOWS_BUILD ;; \
		*) echo "Unsupported OS: $${uname_out}" && exit 1 ;; \
	esac

$(EXEC): $(OBJS) 
	@mkdir -p $(BINDIR)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)
	@echo "Build completed for $(NAME)"

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR) $(BINDIR)

fclean: clean
	rm -rf $(LIBDIR)

DARWIN_BUILD: CFLAGS += 
DARWIN_BUILD: LDFLAGS += -framework Cocoa -framework IOKit -framework CoreFoundation -framework QuartzCore -framework Metal -framework Carbon
DARWIN_BUILD: $(EXEC)
	@echo "Building for Darwin (macOS)"

LINUX_BUILD: CFLAGS +=
LINUX_BUILD: LDFLAGS +=
LINUX_BUILD: $(EXEC)
	@echo "Building for Linux"

WINDOWS_BUILD: CFLAGS +=
WINDOWS_BUILD: LDFLAGS +=
WINDOWS_BUILD: $(EXEC)
	@echo "Building for Windows"

.PHONY: all clean detect_os DARWIN_BUILD LINUX_BUILD WINDOWS_BUILD

