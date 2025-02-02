ppe_project_path="$(pwd)"
ppe_threads="$(nproc --all)"

export ppe_project_path
export ppe_threads
export ppe_scripts_path="$ppe_project_path/pancake"
export ppe_device_name="davinci"
export ppe_arch="arm64"
export ppe_defconfig="pancake_defconfig"
export ppe_kernel_path="$ppe_project_path/kernel/xiaomi/$ppe_device_name"
export ppe_builds_path="$HOME/builds"
export ppe_out_path="out/target/product/$ppe_device_name"
