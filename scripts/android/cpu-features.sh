#!/bin/bash

# CONFIGURE CMAKE
echo "INFO: Configuring cmake for cpu-features..." 1>>"${BASEDIR}"/build.log 2>&1
$(android_ndk_cmake) \
  -DBUILD_TESTING=OFF \
  -DCPU_FEATURES_BUILD_TESTING=OFF \
  -DCPU_FEATURES_BUILD_TESTS=OFF \
  -DCPU_FEATURES_BUILD_BENCHMARKS=OFF \
  1>>"${BASEDIR}"/build.log 2>&1 || {
  echo "ERROR: cmake configuration failed for cpu-features" 1>>"${BASEDIR}"/build.log 2>&1
  return 1
}

# BUILD
echo "INFO: Building cpu-features..." 1>>"${BASEDIR}"/build.log 2>&1
make -C "$(get_cmake_build_directory)" \
  1>>"${BASEDIR}"/build.log 2>&1 || {
  echo "ERROR: make failed for cpu-features" 1>>"${BASEDIR}"/build.log 2>&1
  return 1
}

# INSTALL
echo "INFO: Installing cpu-features..." 1>>"${BASEDIR}"/build.log 2>&1
make -C "$(get_cmake_build_directory)" install \
  1>>"${BASEDIR}"/build.log 2>&1 || {
  echo "ERROR: make install failed for cpu-features" 1>>"${BASEDIR}"/build.log 2>&1
  return 1
}

# CREATE PACKAGE CONFIG MANUALLY
create_cpufeatures_package_config "0.8.0" || return 1
