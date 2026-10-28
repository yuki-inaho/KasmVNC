# Noble integration build

This branch builds the fork's master after its PR #2 merged upstream master.
It is a development snapshot, not the official KasmVNC 1.5.2 release. The
package version sorts above the previous fork package to permit upgrades.

- The upstream VNC-494 handshake bounds checks remain in place. This build
  restores the fortification and stack protection used in the previous Noble
  security build, and uses X.Org 21.1.25 with a pinned archive hash and HTTPS.
- VNC-697 replaces the earlier cache implementation; the four cache regression
  tests cover ordering, lookup, replacement and destruction. The prior fixes
  for pseudo-encoding updates and session ownership are carried forward.
- The web client comes from the pinned `kasmweb` submodule, with a separate
  lockfile for the packages needed to build it. The build disables dependency
  lifecycle scripts and checks that lock against OSV. The libyuv source is
  pinned to a commit. Hashes and advisory checks do not establish that an
  upstream publisher or a source revision is free of malicious changes.

The package still needs the workspace image's HTTPS, multi-viewer, keyboard,
clipboard and GPU runtime acceptance before it is treated as a replacement.
