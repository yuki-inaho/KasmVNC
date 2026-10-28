#!/usr/bin/env bash
# Pin the reviewed Noble build inputs; other distributions may use their own versions.
fetch_source() {
  local component="$1" version="$2" url="$3" file="$4" digest
  case "$component:$version" in
    cpuid:v0.8.2) digest=f23e212e22ca22942cca87b18decdbce8a76d2b004c344a0789d0d26d14930d6 ;;
    fmt:12.2.0) digest=8b852bb5aa6e7d8564f9e81394055395dd1d1936d38dfd3a17792a02bebd7af0 ;;
    tbb:v2023.1.0) digest=191288b52e1e6b17198000b64d77d194bb65e791be46ebc606e9b091781e2070 ;;
    statgrab:LIBSTATGRAB_0_92_1) digest=fb75ba97e6e71f220baf015790e6deb21c77e29e4fbdb3f5de133d7f4564edc8 ;;
    webp:1.6.0) digest=e4ab7009bf0629fd11982d4c2aa83964cf244cffba7347ecd39019a9e38c4564 ;;
    *)
      if [[ "${KASMVNC_BUILD_OS_CODENAME:-}" == noble ]]; then
        echo "No reviewed digest for $component $version" >&2
        return 1
      fi
      digest=''
      ;;
  esac
  curl --fail --location --retry 3 --proto '=https' --proto-redir '=https' "$url" -o "$file" || return 1
  if [[ -n "$digest" ]]; then
    printf '%s  %s\n' "$digest" "$file" | sha256sum --check - || return 1
  fi
}
