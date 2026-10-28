#!/usr/bin/env bash
# Pin the reviewed Noble build inputs; other distributions may use their own versions.
fetch_source() {
  local component="$1" version="$2" url="$3" file="$4" digest
  case "$component:$version" in
    cpuid:v0.8.1) digest=81f2f40da5d66b8220476e116cb40bca4e6a62c0d22bdeeb8e3856cf14607007 ;;
    fmt:12.2.0) digest=8b852bb5aa6e7d8564f9e81394055395dd1d1936d38dfd3a17792a02bebd7af0 ;;
    tbb:v2023.0.0) digest=f8767b971ec6aea25dde58ae0f593e94e7aa75a739a86f67967012f69e2199b1 ;;
    statgrab:LIBSTATGRAB_0_92_1) digest=fb75ba97e6e71f220baf015790e6deb21c77e29e4fbdb3f5de133d7f4564edc8 ;;
    webp:1.5.0) digest=7d6fab70cf844bf6769077bd5d7a74893f8ffd4dfb42861745750c63c2a5c92c ;;
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
