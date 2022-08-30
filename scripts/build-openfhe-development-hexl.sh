#!/bin/sh

CMAKE_FLAGS="-DWITH_INTEL_HEXL=ON -DINTEL_HEXL_PREBUILT=ON -DWITH_NATIVEOPT=ON -DINTEL_HEXL_HINT_DIR=/home/joserochh/mylibs/lib/cmake/hexl-1.2.5" ./scripts/build-openfhe-development.sh
