#!/bin/bash

$(android_ndk_cmake) \
  -DBUILD_TESTING=OFF \
  -DCPU_FEATURES_BUILD_TESTING=OFF \
  -DCPU_FEATURES_BUILD_TESTS=OFF \
  -DCPU_FEATURES_BUILD_BENCHMARKS=OFF || return 1

make -C "$(get_cmake_build_directory)" || return 1

make -C "$(get_cmake_build_directory)" install || return 1

# CREATE PACKAGE CONFIG MANUALLY
create_cpufeatures_package_config "0.8.0" || return 1
