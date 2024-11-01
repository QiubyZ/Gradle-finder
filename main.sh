#!/bin/bash

# Fungsi untuk mencari file di direktori parent
find_parent_files() {
 local start_path="$1"
 shift
 local filenames=("$@")
 local current_path=$(readlink -f "$start_path")
 local found_files=()

 while true; do
  local parent_path=$(dirname "$current_path")

  # Jika direktori parent sama dengan direktori saat ini, keluar dari loop
  if [[ "$parent_path" == "$current_path" ]]; then
   break
  fi

  current_path="$parent_path"

  # Periksa setiap file di direktori parent
  for filename in "${filenames[@]}"; do
   if [[ -f "$current_path/$filename" ]]; then
    # Buat asosiasi nama file dengan path
    local filepath="$current_path/$filename"
    found_files+=("$filepath")
   fi
  done

  # Jika semua file ditemukan, keluar dari loop
  if [[ ${#found_files[@]} -eq ${#filenames[@]} ]]; then
   break
  fi
 done

 # Kembalikan array asosiasi file yang ditemukan
 echo "${found_files[@]}"
}

# Fungsi utama
main() {
 local start_path="$1"
 local gradle_args="$2"
 local filenames=("gradlew" "settings.gradle" "settings.gradle.kts")
 local found_files=()

 # Panggil fungsi untuk mencari file
 found_files=($(find_parent_files "$start_path" "${filenames[@]}"))

 # Jika file ditemukan
 if [[ ${#found_files[@]} -gt 0 ]]; then
  # Ambil direktori common dari file yang ditemukan
  local common_path=$(dirname "${found_files[0]}" )
  echo "Direktori common: $common_path"

  # Jalankan perintah Gradle
  cd "$common_path" && gradle "$gradle_args"
 else
  echo "File tidak ditemukan di direktori parent."
 fi
}

# Jalankan fungsi utama
main "$1" "$2"