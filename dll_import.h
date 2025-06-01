// mm_binds_rs_defines.h
#ifndef MM_BINDS_RS_DEFINES_H
#define MM_BINDS_RS_DEFINES_H

// --- Essential Platform Defines for Source SDK on Linux ---
// These should make platform.h recognize the environment as Linux/POSIX.
#define POSIX 1
#define LINUX 1

// __linux__ is typically defined by GCC/Clang on Linux, but being explicit can help.
#ifndef __linux__
  #define __linux__ 1
#endif

#ifndef _LINUX
  #define _LINUX 1
  typedef unsigned long uintptr_t;
#endif

// Source SDK headers often check for __GNUC__ for GCC-like compilers (including Clang).
// Clang defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__ to mimic GCC.
// Defining them ensures they are present if platform.h relies on them before Clang's built-ins are fully effective
// or if there's any check that might be missed.
#ifndef __GNUC__
  #define __GNUC__ 4 // Using a common version, e.g., 4.x.x
  #define __GNUC_MINOR__ 8 // Example minor version
  #define __GNUC_PATCHLEVEL__ 0 // Example patch level
#endif

// Valve-specific compiler identifiers.
// COMPILER_GCC is often checked. Clang is usually compatible.
#ifndef COMPILER_GCC
  #define COMPILER_GCC 1
#endif

// Some SDKs might also check for COMPILER_CLANG if Clang-specific features are used.
// If you know your SDK specifically uses COMPILER_CLANG, you can enable this.
// #if defined(__clang__) && !defined(COMPILER_CLANG)
//   #define COMPILER_CLANG 1
// #endif

// The DLL_IMPORT/DLL_EXPORT macros are usually defined *within* platform.h
// after platform detection. If platform detection is successful with the above,
// these should not be needed here. Only uncomment as a last resort if DLL_IMPORT
// errors persist despite platform detection seeming to work.
/*
#ifndef DLL_IMPORT
  #define DLL_IMPORT
#endif
#ifndef DLL_EXPORT
  #define DLL_EXPORT __attribute__((visibility("default")))
#endif
#ifndef STDCALL
  #define STDCALL
#endif
#ifndef FASTCALL
  #define FASTCALL
#endif
#ifndef FORCEINLINE
  #define FORCEINLINE inline __attribute__((always_inline))
#endif
#ifndef NOINLINE
  #define NOINLINE __attribute__((noinline))
#endif
*/

#endif // MM_BINDS_RS_DEFINES_H
