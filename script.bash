#!/bin/bash
set -e
export LC_ALL=C
source "$ppe_scripts_path/helpers/patch.bash"

cd $ppe_project_path || return

get_latest_out_zip () {
  echo "$(echo $ppe_out_path/PixelExperience*.zip | sort | tail -n1)"
}

build_rom () {
  mka bacon -j"$ppe_threads"
  zip_name="$(basename $(get_latest_out_zip))"
  mv "$ppe_out_path/$zip_name" "$ppe_builds_path"
  echo -e "\nResult file: $ppe_builds_path/$zip_name"
}

build_kernel () {
  mka bootimage -j"$ppe_threads"
  timestamp="$(date +%s)"
  result_path="$ppe_builds_path/boot/boot-$timestamp.img"
  mv "$ppe_out_path/boot.img" "$result_path"
  echo "$result_path"
}

configure () {
  kmake "$ppe_defconfig"
}

sync () {
  repo sync -c \
    -j"$ppe_threads" \
    --force-sync \
    --no-clone-bundle \
    --no-tags
  apply_patches "$ppe_scripts_path/patches"
}

print_success () {
  echo -e "\n\e[92m$1\e[90m | $(date +%R)"
}

regenerate () {
  cd $ppe_kernel_path
  configure
  kmake savedefconfig
  cp -f out/defconfig "arch/$ppe_arch/configs/$ppe_defconfig"
}

init_build () {
  mkdir -p $ppe_builds_path
  source build/envsetup.sh
  lunch "aosp_$ppe_device_name-userdebug"
  mka installclean -j"$ppe_threads"
}

case "$1" in
  regenerate|r)
    regenerate
    print_success "$ppe_defconfig successfully regenerated"
    ;;
  build-kernel|bk)
    init_build
    build_kernel
    print_success "Kernel successfully builded"
    ;;
  build|b)
    init_build
    build_rom
    print_success "ROM successfully builded"
    ;;
  sync|s)
    sync
    print_success "Sources successfully synchronized"
  ;;
esac
