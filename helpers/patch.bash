reset_repo() {
  repo sync -l --force-sync "$1" || continue
  pushd "$1" || continue
  git clean -fdx
  git reset --hard
  popd || continue
}

apply_patches() {
  patches_dir="$1"

  for project in $(
    cd "$patches_dir" || return
    echo *
  ); do
    project_path="$(tr _ / <<<"$project")"
    reset_repo "$project_path"

    for patch in $patches_dir/$project/*.patch; do
      patch=$(readlink -f "$patch")
      pushd "$project_path" || continue
      if patch -f -p1 --dry-run -R <"$patch" >/dev/null; then
        echo "Already patched."
        popd || continue
        continue
      fi
      if git apply --check "$patch"; then
        git am "$patch"
      elif patch -f -p1 --dry-run <"$patch" >/dev/null; then
        #This will fail
        git am "$patch" || true
        patch -f -p1 <"$patch"
        git add -u
        git am --continue
      else
        echo -e "\033[01;31m\n Failed applying $patch ... 033[0m"
      fi
      popd || continue
    done
  done
}
