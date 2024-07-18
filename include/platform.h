#ifndef PLATFORM_H
#define PLATFORM_H

#if defined(_WIN32) || defined(_WIN64)
    #define PLATFORM_WINDOWS
    #include <windows.h>
#elif defined(__linux__)
    #define PLATFORM_LINUX
    #include <unistd.h>
#elif defined(__APPLE__) && defined(__MACH__)
    #define PLATFORM_DARWIN
    #include "Darwin.h"
#else
    #error "Unsupported platform"
#endif

#if defined(__GNUC__)
    #define COMPILER_GCC
#elif defined(__clang__)
    #define COMPILER_CLANG
#elif defined(_MSC_VER)
    #define COMPILER_MSVC
#else
    #error "Unsupported compiler"
#endif

#if defined(__x86_64__) || defined(_M_X64)
    #define ARCH_X64
#elif defined(__i386__) || defined(_M_IX86)
    #define ARCH_X86
#elif defined(__arm__) || defined(_M_ARM)
    #define ARCH_ARM
#elif defined(__aarch64__)
    #define ARCH_ARM64
#else
    #error "Unsupported architecture"
#endif

#endif // PLATFORM_H

