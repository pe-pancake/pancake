kmake_flags=(
	-j"${ppe_threads}"
	ARCH="$ppe_arch"
	O="out"
)

# Main wrapper for all `make` functions
kmake () {
  make "${kmake_flags[@]}" "$@"
}
