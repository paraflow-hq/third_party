#!/usr/bin/env bash

set -eu

cd angle

# config
gn gen out/Release --args=" \
  is_debug=false \
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
ninja -C out/Release libEGL libGLESv2 libvulkan swiftshader_libvulkan

# cancel patch
git checkout -f
