# Shuttle Upgrade Tasks

## Phase 1 — Apple Silicon (minimal)
- [x] Fix apple-scripts compile paths to be repo-relative
- [x] Regenerate Shuttle/apple-scpt/*.scpt (Terminal + Virtual; iTerm needs iTerm2 installed — committed .scpt kept)
- [x] Restore or recreate missing icon assets (StatusIcon*.png, shuttle.icns)
- [x] Set Release ARCHS=arm64 in Xcode project
- [x] Build Release on Apple Silicon (`build/Release/Shuttle.app` — **BUILD SUCCEEDED**)
- [x] Verify `file` shows arm64 and app runs without Rosetta (`Mach-O 64-bit executable arm64`)
- [x] Smoke test Terminal + iTerm2 AppleScript handlers (Terminal handler OK — new window ran `echo SHUTTLE_PHASE1_SMOKE_OK`; Automation already granted for `shuttle.Shuttle`; iTerm2 not installed so iTerm handlers skipped)
- [x] License / attribution for personal GitHub fork (keep open source, free; no logo changes)
  - [x] Keep MIT `LICENSE` with original `Copyright (c) 2013 Trevor Fitzgerald` notice
  - [x] Add your copyright line for modifications (`Copyright (c) 2026 David Engblom`)
  - [x] Update `NSHumanReadableCopyright` in `Shuttle/Shuttle-Info.plist` (About box reads this) — credit fork maintainer + note based on original
  - [x] Update README for your GitHub remote (install/build links, retain credit to Trevor Fitzgerald / original project)
  - [x] Leave logo / icons unchanged (`shuttle.icns`, `StatusIcon*.png`)
- [x] Fix host open Finder error -50: only treat `cmd` as URL when it has an explicit scheme (bare `ssh user@host` was incorrectly passed to `NSWorkspace openURL`)
- [x] Fix Terminal tab AppleScripts: stop using System Events Cmd+T alone (needs Accessibility; failed with 1002 so `cmd` never ran)
- [x] Fix second-host reuse: `do script … in front window` reuses selected tab; tab mode now Cmd+T when Accessibility allowed, else bare `do script` (new window / Dock-prefer-tabs)
- [x] Install arm64 build to `/Applications/Shuttle.app` so Accessibility TCC matches the running binary (grant on `/Applications` did not apply to `build/Release/`)
- [x] Fix tab+extra-window: after UI New Tab, paste+Return into that tab instead of `do script` (which opened a second window for the SSH session)
- [x] Fix tab+window again: only Cmd+T (no Shell menu click); if tab created, type cmd+Return into it — never `do script` after Cmd+T (that spawned the extra window)

## Phase 2 — Build & project hygiene
- [x] Add Shuttle.xcodeproj/xcshareddata/xcschemes/Shuttle.xcscheme for CLI builds
- [x] Bump MACOSX_DEPLOYMENT_TARGET (10.8/10.9 → 11.0; Apple Silicon Macs require Big Sur minimum anyway)
- [x] Upgrade project format (objectVersion 54 / LastUpgradeCheck 2600 / compatibilityVersion Xcode 14.0)
- [x] Keep committed `.scpt` + icons; add `apple-scripts/prepare.sh` and document in README
- [x] Add basic build instructions to README (scheme-based `xcodebuild`, prepare script, permissions)

## Phase 3 — Code signing & distribution
- [ ] Set DEVELOPMENT_TEAM and CODE_SIGN_IDENTITY (currently empty)
- [ ] Enable Hardened Runtime (ENABLE_HARDENED_RUNTIME = YES)
- [ ] Review entitlements: replace temporary Apple Events exception with proper Automation usage
- [ ] Notarize for Gatekeeper-friendly distribution
- [ ] Publish arm64 (or universal) release replacing fitztrev.github.io Intel binary

## Phase 4 — Deprecated API modernization
- [ ] Replace LSSharedFileList login-item APIs in LaunchAtLoginController.m with SMAppService (macOS 13+) or ServiceManagement
- [ ] Convert LaunchAtLoginController.m to ARC (currently -fno-objc-arc)
- [ ] Remove NSMakeCollectable usage (deprecated)
- [ ] Audit manual retain/release in AppDelegate.m for ARC migration

## Phase 5 — AppleScript & terminal compatibility
- [ ] Test all 9 AppleScript handlers against current Terminal.app and iTerm2
- [ ] Verify iTerm2 bundle ID in Shuttle.entitlements (com.googlecode.iterm2)
- [ ] Update iTerm nightly scripts if iTerm API changed since 2016
- [ ] Consider consolidating iTerm stable/nightly script variants

## Phase 6 — CI & quality
- [ ] Add GitHub Actions: xcodebuild on macos-latest (arm64 runner)
- [ ] Add lint/static analysis pass
- [ ] Document test configs in tests/ for regression checks

## Phase 7 — Nice-to-have (from CHANGELOG roadmap)
- [ ] Preferences panel
- [ ] Update notifications
- [ ] Keyboard hotkeys
- [ ] Cloud provider menu integration
