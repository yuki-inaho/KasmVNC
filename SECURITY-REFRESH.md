# Noble security refresh — 2026-10-22

Base: upstream v1.5.0 (17265facc40ab50db5740cdf0d12c61173edafc9).

## Selected upstream changes
- #372 (a05a0984f55d4aa4de15b001f581c5015c177d78): strict cache key ordering, replacement ownership and destruction, with standalone regression tests.
- #362 (5e97a459c7f1d97f416ee7cd1be7cb1643488527): flush pending pseudo-encoding updates in video mode. Supersedes #358; do not apply both.
- #369 (6a78742ce1e04ed0f961701f6bfb7b3deea8f447): initialize permission flags, report ownership and clear the disconnected session list.
- Noble X.Org build: 21.1.12 -> 21.1.25. Official archive: https://www.x.org/archive/individual/xserver/
- X.Org downloads require verified HTTPS without HTTP fallback and check SHA256 fdb5ec9b4ab7371745b182b68c7054ed72fc4d13e185fc369cfc45e0c3a174e7 from the preceding handoff; the CI download matched it.
- Pinned build versions: libjpeg-turbo 3.2.0, oneTBB v2023.1.0, libcpuid v0.8.2, fmt 12.2.0. Other inherited dependencies are not claimed fully reproducible.

PR references: https://github.com/kasmtech/KasmVNC/pulls

Not selected: #353 modifies legacy client TLS code while this server build disables GNUTLS and the viewer; #354 changes only the legacy encoding benchmark and is not a server security fix. #333 is README spelling.

## Validation evidence

Code commit: 4c551b7b410b04525c3b41fa56224bb5c914519a.
Successful CI: https://github.com/yuki-inaho/KasmVNC/actions/runs/39718135933

- Four actual EncCache tests passed with AddressSanitizer and LeakSanitizer.
- Noble package build and installation passed.
- Xvnc reported embedded X.Org release 12101025.
- Package revision: 1.5.0-1+yuki20261022.
- SHA256: cca0dafd37819add492d2f6bd020d41f2ea24e6574b4fe4525095eb9b6a67856.
- Release: https://github.com/yuki-inaho/KasmVNC/releases/tag/v1.5.0-noble-4c551b7b410b

The unchanged web client is reused from the official 1.5.0 Noble package,
verified against SHA256 f599fe02e2175b9817b6165f74a5d2bebdc73118dde9181ba3410963bed7ae1e.
This avoids the unmodified web source's unconstrained Babel major-version conflict.
All server code is rebuilt from this fork.

Workspace integration: https://github.com/yuki-inaho/docker-template-kasm-noble-ai-workspace/commit/df7fd876febcf2b53d6c80a8c2b378968bc2925b
Its CI requires standard/full smoke and security checks plus HTTPS authentication
and two browser viewers receiving rendered pixels before image publishing.
Consult the workspace CI for its current result. Japanese IME interaction,
clipboard behavior and NVIDIA hardware acceptance are separate checks; no
successful execution of those checks is asserted here.

This is a targeted maintenance build, not a complete vulnerability audit.
