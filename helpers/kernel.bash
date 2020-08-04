kmake_flags=(
	-j"${threads}"
	ARCH="$arch"
	O="out"
)

# Main wrapper for all `make` functions
kmake () {
  make "${kmake_flags[@]}" "$@"
}

# Generate build config
configure () {
  kmake "$defconfig"
}
