#!/usr/bin/env bash

set -eu

cd angle

# Set target CPU architecture (default to x64 if not specified)
TARGET_CPU=${TARGET_CPU:-"x64"}

# config
gn gen ../out/Release --args=" \
  is_debug=false \
  target_cpu=\"$TARGET_CPU\" \
  angle_enable_vulkan=true \
  angle_enable_swiftshader=true \
  angle_enable_gl=false \
  angle_enable_gl_desktop_backend=false \
  angle_enable_wgpu=false \
  angle_enable_null=false \
  angle_use_x11=false \
  angle_has_histograms=false \
  angle_build_tests=false"

git checkout -f
# use SwiftShader default
sed -i -e 's/return angle::vk::ICD::Default;/return angle::vk::ICD::SwiftShader;/g' src/libANGLE/renderer/vulkan/DisplayVk.cpp

# build
ninja -C ../out/Release libEGL libGLESv2 libvulkan swiftshader_libvulkan

# cancel patch
git checkout -f
