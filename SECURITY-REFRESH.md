# Noble security refresh — 2026-10-26

Base: upstream v1.5.0 (17265facc40ab50db5740cdf0d12c61173edafc9), plus the
KSN-2026-006 WebSocket handshake fix backported from v1.5.2.

## Selected upstream changes
- KSN-2026-006 (0b8248b150ff6c7348e871fc193c47fb59bd3d8f): bound WebSocket handshake header copies and enable hardening flags. Backported to the 1.5.0 source; does not change X.Org.
- #372 (a05a0984f55d4aa4de15b001f581c5015c177d78): strict cache key ordering, replacement ownership and destruction, with standalone regression tests.
- #362 (5e97a459c7f1d97f416ee7cd1be7cb1643488527): flush pending pseudo-encoding updates in video mode. Supersedes #358; do not apply both.
- #369 (6a78742ce1e04ed0f961701f6bfb7b3deea8f447): initialize permission flags, report ownership and clear the disconnected session list.
- Noble X.Org build: 21.1.12 -> 21.1.25. Official archive: https://www.x.org/archive/individual/xserver/
- X.Org downloads now require verified HTTPS without HTTP fallback. Archive digest pinning remains to be added after independent verification.

PR references: https://github.com/kasmtech/KasmVNC/pulls

Not selected: #353 modifies legacy client TLS code while this server build disables GNUTLS and the viewer; #354 changes only the legacy encoding benchmark and is not a server security fix. #333 is README spelling.

## Validation status
Locally compiled the real EncCache implementation and passed ordering, lookup, replacement and destruction with AddressSanitizer. LeakSanitizer cannot run in the execution sandbox (/proc access failure); the workflow requires it on Ubuntu.

Full Noble package build and X.Org version verification are required in GitHub Actions. HTTPS authentication, two-viewer screen updates, Japanese IME/keyboard, clipboard, resize and GPU runtime acceptance remain required before deployment. No assertion of complete vulnerability coverage or successful runtime validation is made.

The existing workspace template must only consume a successfully built, checksum-pinned package. Do not switch production to an unbuilt artifact.
