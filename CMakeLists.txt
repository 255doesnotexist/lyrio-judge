project(lyrio-judge)
cmake_minimum_required(VERSION 3.0)

find_package(fmt)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-Wall -std=c++17")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(${CMAKE_JS_INC})

# Builtin Checkers
add_library(
    builtin_checkers
    SHARED
    ${CMAKE_JS_SRC}
    "native/builtin_checkers/builtin_checkers.cc"
    "native/builtin_checkers/integers.h"
    "native/builtin_checkers/floats.h"
    "native/builtin_checkers/lines.h"
    "native/builtin_checkers/binary.h"
)
set_target_properties(builtin_checkers PROPERTIES PREFIX "" SUFFIX ".node")
target_include_directories(builtin_checkers PRIVATE 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api/src
    ${CMAKE_JS_INC}
    "vendor/testlib"
)
target_link_libraries(builtin_checkers PRIVATE ${CMAKE_JS_LIB})

# POSIX
add_library(
    posix
    SHARED
    ${CMAKE_JS_SRC}
    "native/posix/posix.cc"
)
set_target_properties(posix PROPERTIES PREFIX "" SUFFIX ".node")
target_include_directories(posix PRIVATE 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api/src
    ${CMAKE_JS_INC}
)
target_link_libraries(posix PRIVATE ${CMAKE_JS_LIB})

# fs_native
add_library(
    fs_native
    SHARED
    ${CMAKE_JS_SRC}
    "native/fs_native/fs_native.cc"
)
set_target_properties(fs_native PROPERTIES PREFIX "" SUFFIX ".node")
target_include_directories(fs_native PRIVATE 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api 
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api/src
    ${CMAKE_JS_INC}
)
target_link_libraries(fs_native PRIVATE ${CMAKE_JS_LIB} stdc++fs)

# Simple Sandbox (internal)
add_library(
    sandbox
    SHARED
    ${CMAKE_JS_SRC}
    "simple-sandbox/native/addon.cc"
    "simple-sandbox/native/cgroup.cc"
    "simple-sandbox/native/cgroup.h"
    "simple-sandbox/native/pipe.cc"
    "simple-sandbox/native/pipe.h"
    "simple-sandbox/native/sandbox.cc"
    "simple-sandbox/native/sandbox.h"
    "simple-sandbox/native/semaphore.cc"
    "simple-sandbox/native/semaphore.h"
    "simple-sandbox/native/utils.cc"
    "simple-sandbox/native/utils.h"
)
set_target_properties(sandbox PROPERTIES PREFIX "" SUFFIX ".node")
target_include_directories(sandbox PRIVATE
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api
    ${CMAKE_SOURCE_DIR}/node_modules/node-addon-api/src
    ${CMAKE_JS_INC}
)
target_link_libraries(sandbox PRIVATE ${CMAKE_JS_LIB} fmt::fmt)
