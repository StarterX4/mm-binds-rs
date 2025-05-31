#!/bin/bash
# Consider adding these lines for more robust script behavior:
set -euo pipefail

BASE_OPTS="--use-core --enable-cxx-namespaces --rust-target 1.86"
INCLUDES="-include dll_import.h -include metamod_oslink.h -I mmsource/core -I mmsource/core/sourcehook -I mmsource/third_party/amtl -I mmsource/loader -I mmsource/versionlib -I mmsource/core/provider/source -I mmsource/core/provider "

# Define the base path for the SDK public directory
HL2SDK="/kesz/Budowanie/alliedmodders/hl2sdk-l4d2/public"

# Dynamically add subdirectories (1 and 2 levels deep) from the SDK public path
INCLUDES+=$(find ${HL2SDK} -type d -printf '-I %p ')
CLANG_OPTS="-x c++ -std=c++11 -DLINUX=1 -DPOSIX=1 $INCLUDES"

### Core ###
### SourceHook ###
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook.h -o src/sourcehook/sourcehook.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_hookmangen.h -o src/sourcehook/sourcehook_hookmangen.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_hookmangen_x86.h -o src/sourcehook/sourcehook_hookmangen_x86.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_chook.h -o src/sourcehook/sourcehook_impl_chook.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_chookidman.h -o src/sourcehook/sourcehook_impl_chookidman.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_chookmaninfo.h -o src/sourcehook/sourcehook_impl_chookmaninfo.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_ciface.h -o src/sourcehook/sourcehook_impl_ciface.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_cleanuptask.h -o src/sourcehook/sourcehook_impl_cleanuptask.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_cproto.h -o src/sourcehook/sourcehook_impl_cproto.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl_cvfnptr.h -o src/sourcehook/sourcehook_impl_cvfnptr.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_impl.h -o src/sourcehook/sourcehook_impl.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sourcehook_pibuilder.h -o src/sourcehook/sourcehook_pibuilder.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/FastDelegate.h -o src/sourcehook/fastdelegate.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_asm.h -o src/sourcehook/sh_asm.rs -- $CLANG_OPTS
# DOESNT WORK due to bindgen lacking some C++ features(?): bindgen $BASE_OPTS mmsource/core/sourcehook/sh_asm_x86_64.h -o src/sourcehook/sh_asm_x86_64.rs -- $CLANG_OPTS -fblocks -std=c++17
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_list.h -o src/sourcehook/sh_list.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_memfuncinfo.h -o src/sourcehook/sh_memfuncinfo.rs -- $CLANG_OPTS -include sourcehook.h
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_memory.h -o src/sourcehook/sh_memory.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_pagealloc.h -o src/sourcehook/sh_pagealloc.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_stack.h -o src/sourcehook/sh_stack.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_string.h -o src/sourcehook/sh_string.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_tinyhash.h -o src/sourcehook/sh_tinyhash.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/sourcehook/sh_vector.h -o src/sourcehook/sh_vector.rs -- $CLANG_OPTS
### Provider ###
bindgen $BASE_OPTS mmsource/core/provider/provider_base.h -o src/provider/provider_base.rs -- $CLANG_OPTS
### MetaMod ###
bindgen $BASE_OPTS mmsource/core/IPluginManager.h -o src/plugin_manager.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/ISmmAPI.h -o src/mm_api.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/ISmmPluginExt.h -o src/plugin_ext.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/ISmmPlugin.h -o src/plugin.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_console.h -o src/metamod_console.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_convar.h -o src/metamod_convar.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod.h -o src/metamod.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_oslink.h -o src/metamod_oslink.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_plugins.h -o src/metamod_plugins.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_provider.h -o src/metamod_provider.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/core/metamod_util.h -o src/metamod_util.rs -- $CLANG_OPTS
### Loader ###
bindgen $BASE_OPTS mmsource/loader/gamedll.h -o src/loader/gamedll.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/loader/loader_bridge.h -o src/loader/loader_bridge.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/loader/loader.h -o src/loader/loader.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/loader/serverplugin.h -o src/loader/serverplugin.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/loader/utility.h -o src/loader/utility.rs -- $CLANG_OPTS
### Public ###
bindgen $BASE_OPTS mmsource/public/metamod_version.h -o src/metamod_version.rs -- $CLANG_OPTS
### VersionLib ###
bindgen $BASE_OPTS mmsource/versionlib/versionlib.h -o src/versionlib/versionlib.rs -- $CLANG_OPTS
### AMTL ###
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-allocator-policies.h -o src/amtl/am_allocator_policies.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-arithmetic.h -o src/amtl/am_arithmetic.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-assert.h -o src/amtl/am_assert.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-bits.h -o src/amtl/am_bits.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-cxx.h -o src/amtl/am_cxx.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-deque.h -o src/amtl/am_deque.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-enum.h -o src/amtl/am_enum.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-fixedarray.h -o src/amtl/am_fixedarray.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-flags.h -o src/amtl/am_flags.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-float.h -o src/amtl/am_float.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-function.h -o src/amtl/am_function.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-hashmap.h -o src/amtl/am_hashmap.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-hashset.h -o src/amtl/am_hashset.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-hashtable.h -o src/amtl/am_hashtable.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-inlinelist.h -o src/amtl/am_inlinelist.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-linking.h -o src/amtl/am_linking.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-maybe.h -o src/amtl/am_maybe.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-mutex.h -o src/amtl/am_mutex.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-platform.h -o src/amtl/am_platform.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-priority-queue.h -o src/amtl/am_priority_queue.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-raii.h -o src/amtl/am_raii.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-refcounting-threadsafe.h -o src/amtl/am_refcounting_threadsafe.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-refcounting.h -o src/amtl/am_refcounting.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-storagebuffer.h -o src/amtl/am_storagebuffer.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-string.h -o src/amtl/am_string.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-thread.h -o src/amtl/am_thread.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-threadlocal.h -o src/amtl/am_threadlocal.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-time.h -o src/amtl/am_time.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-unused.h -o src/amtl/am_unused.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-utility.h -o src/amtl/am_utility.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/am-vector.h -o src/amtl/am_vector.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/experimental/am-argparser.h -o src/amtl/experimental/am_argparser.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-fsutil-posix.h -o src/amtl/os/am_fsutil_posix.rs -- $CLANG_OPTS
#UNSUPPORTED PLATFORM: bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-fsutil-windows.h -o src/amtl/os/am_fsutil_windows.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-fsutil.h -o src/amtl/os/am_fsutil.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-path.h -o src/amtl/os/am_path.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-shared-library.h -o src/amtl/os/am_shared_library.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/amtl/os/am-system-errors.h -o src/amtl/os/am_system_errors.rs -- $CLANG_OPTS
bindgen $BASE_OPTS mmsource/third_party/amtl/tests/runner.h -o src/amtl/tests/runner.rs -- $CLANG_OPTS