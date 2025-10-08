#!/usr/bin/env bash
set -euo pipefail

APPDIR="appconf"
HEX_OUT="build/BLDC_4_ChibiOS.hex"
BIN_OUT="build/BLDC_4_ChibiOS.bin"

make clean

for i in {0..3}; do
  rm -f "${APPDIR}/skygauge_app.h"
  cp "${APPDIR}/skygauge_app_${i}.h" "${APPDIR}/skygauge_app.h"   # use mv if you truly want to rename
  make
  test -f "${HEX_OUT}" || { echo "build failed for index ${i}"; exit 1; }
  mv -f "${HEX_OUT}" "build/acu_${i}.hex"
  mv -f "${BIN_OUT}" "build/acu_${i}.bin"
done

# convert WSL path to Windows and open in Explorer
explorer.exe "$(wslpath -w ./build)"
