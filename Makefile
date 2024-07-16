NAME = AutoKey

SRCDIR = src
INCDIR = include
OBJDIR = obj
BINDIR = bin
LIBDIR = lib

AKSCRIPTDIR = $(SRCDIR)/AKScript

DARWINDIR = $(AKSCRIPTDIR)/Darwin
LINUXDIR = $(AKSCRIPTDIR)/Linux
WINDOWSDIR = $(AKSCRIPTDIR)/Windows

INCLUDE_DIRS =	$(INCDIR) 			\
				$(INCDIR)/AKScript	\

INCLUDE_FLAGS = $(addprefix -I, $(INCLUDE_DIRS))

SRCS = main.c							\
        $(DARWINDIR)/WinFunctions.c		\
        $(LINUXDIR)/WinFunctions.c      \
        $(WINDOWSDIR)/WinFunctions.c	\

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
EXEC = $(BINDIR)/$(NAME)

CC = gcc
CFLAGS = -Wall -Wextra $(INCLUDE_FLAGS) -Ilib/glfw/include
LDFLAGS = -Llib/glfw/build/src -lglfw3 -lm -ldl -lpthread

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
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR) $(BINDIR)

fclean: clean
	rm -rf $(LIBDIR)

glfw:
	@mkdir -p lib
	@[ -d lib/glfw ] || git clone https://github.com/glfw/glfw.git lib/glfw
	@mkdir -p lib/glfw/build
	cmake -S lib/glfw lib/glfw/build
	cmake --build lib/glfw/build

DARWIN_BUILD: CFLAGS += 
DARWIN_BUILD: LDFLAGS += -framework Cocoa -framework IOKit -framework CoreFoundation -framework QuartzCore -framework Metal
DARWIN_BUILD: glfw $(EXEC)
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

