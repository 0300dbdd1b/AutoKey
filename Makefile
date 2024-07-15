NAME = AutoKey

SRCDIR = src
INCDIR = include
OBJDIR = obj
BINDIR = bin
LIBDIR = lib
DARWINDIR = $(SRCDIR)/SystemManager/Darwin
LINUXDIR = $(SRCDIR)/SystemManager/Linux
WINDOWSDIR = $(SRCDIR)/SystemManager/Windows

SRCS = main.c                          \
        $(DARWINDIR)/WinFunctions.c     \
        $(LINUXDIR)/WinFunctions.c      \
        $(WINDOWSDIR)/WinFunctions.c

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
EXEC = $(BINDIR)/$(NAME)

CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

all: detect_os

detect_os:
	@uname_out=$$(uname -s) || exit 1; \
	case $${uname_out} in \
		Darwin*)  $(MAKE) DARWIN_BUILD ;; \
		Linux*)   $(MAKE) LINUX_BUILD ;; \
		MINGW* | MSYS* | CYGWIN*) $(MAKE) WINDOWS_BUILD ;; \
		*)        echo "Unsupported OS: $${uname_out}" && exit 1 ;; \
	esac

$(EXEC): $(OBJS)
	@mkdir -p $(BINDIR)
	$(CC) $(OBJS) -o $@
	@echo "Build completed for $(NAME)"

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR) $(BINDIR)

DARWIN_BUILD: CFLAGS += -DSYSTEM=\"Darwin\"
DARWIN_BUILD: $(EXEC)
	@echo "Building for Darwin (macOS)"

LINUX_BUILD: CFLAGS += -DSYSTEM=\"Linux\"
LINUX_BUILD: $(EXEC)
	@echo "Building for Linux"

WINDOWS_BUILD: CFLAGS += -DSYSTEM=\"Windows\"
WINDOWS_BUILD: $(EXEC)
	@echo "Building for Windows"

.PHONY: all clean detect_os DARWIN_BUILD LINUX_BUILD WINDOWS_BUILD

