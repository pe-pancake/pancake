export ppe_project_path="$(pwd)"
export ppe_scripts_path="$ppe_project_path/scripts"

threads=0

while getopts "j:" opt
do
  case $opt in
    j) threads="$OPTARG";;
    *) exit;;
  esac
done

if [ "$threads" -eq "0" ]
then
  threads="$(nproc --all)"
fi

export ppe_threads="$threads"
export ppe_device_name="davinci"
export ppe_arch="arm64"
export ppe_defconfig="pancake_defconfig"
export ppe_kernel_path="$ppe_project_path/kernel/xiaomi/sm6150"
export ppe_builds_path="$HOME/builds"

export LC_ALL=C
