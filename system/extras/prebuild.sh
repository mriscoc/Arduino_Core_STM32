#!/bin/bash

BUILD_PATH="$1"
BUILD_SOURCE_PATH="$2"
BOARD_PLATFORM_PATH="$3"

# Create sketch dir if not exists
if [ ! -f "$BUILD_PATH/sketch" ]; then
  mkdir -p "$BUILD_PATH/sketch"
fi

# Create empty build.opt.h if not exists in the original sketch dir
if [ ! -f "$BUILD_SOURCE_PATH/build_opt.h" ]; then
  touch "$BUILD_PATH/sketch/build_opt.h"
fi

# Append -fmacro-prefix-map option to change __FILE__ absolute path of the board
# platform folder to a relative path by using '.'.
# (i.e. the folder containing boards.txt)
printf '\n-fmacro-prefix-map=%s=.' "${BOARD_PLATFORM_PATH//\\/\\\\}" > "$BUILD_PATH/sketch/build.opt"

# Force include of SrcWrapper library
echo "#include <SrcWrapper.h>" >"$BUILD_PATH/sketch/SrcWrapper.cpp"
