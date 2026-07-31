# Shuttle

A simple shortcut menu for macOS.

This is a maintained fork of [fitztrev/shuttle](https://github.com/fitztrev/shuttle), updated to build natively for Apple Silicon. It remains free and open source under the MIT License.

**Repository:** [https://github.com/dengblom/shuttle](https://github.com/dengblom/shuttle)

![How Shuttle works](https://raw.githubusercontent.com/fitztrev/shuttle/gh-pages/images/how-shuttle-works.gif)

## Requirements

- Apple Silicon Mac (arm64)
- macOS 11 Big Sur or later
- Xcode (full app, not only Command Line Tools)

## Installation (build from source)

```bash
git clone https://github.com/dengblom/shuttle.git
cd shuttle

# Optional: regenerate compiled AppleScripts (icons are already committed)
./apple-scripts/prepare.sh
# Or skip iTerm recompile attempts: SKIP_ITERM=1 ./apple-scripts/prepare.sh

xcodebuild -project Shuttle.xcodeproj -scheme Shuttle -configuration Release \
  SYMROOT="$PWD/build" build
open build/Release/Shuttle.app
```

Copy `build/Release/Shuttle.app` to `/Applications` for day-to-day use (recommended so Accessibility TCC matches the installed binary).

> Without `SYMROOT`, Xcode writes into `~/Library/Developer/Xcode/DerivedData/`.

### Upgrading from the Intel (Rosetta) build

If you already have the old prebuilt Shuttle (x86_64, often from [fitztrev.github.io/shuttle](http://fitztrev.github.io/shuttle/)) in `/Applications`, replace it with the arm64 build. Your `~/.shuttle.json` config is unchanged and does not need to be migrated.

```bash
# 1. Quit every running Shuttle (Intel and any local builds)
pkill -f 'Shuttle.app/Contents/MacOS/Shuttle' || true

# 2. Build this fork (see steps above), then replace the app
#    Optional backup of the Intel app:
mv /Applications/Shuttle.app /Applications/Shuttle.app.intel-backup

ditto build/Release/Shuttle.app /Applications/Shuttle.app
xattr -cr /Applications/Shuttle.app

# 3. Confirm the new binary is native arm64 (not x86_64)
file /Applications/Shuttle.app/Contents/MacOS/Shuttle
# Expected: Mach-O 64-bit executable arm64

# 4. Launch from Applications (not from build/ or a leftover Intel copy)
open -a /Applications/Shuttle.app
```

Then fix permissions — macOS treats a replaced binary as a new app even if the name matches:

1. **System Settings → Privacy & Security → Accessibility**  
   - If Shuttle is listed: toggle **off**, then **on**.  
   - If missing: click **+** and add `/Applications/Shuttle.app`.  
   Required for `"open_in": "tab"` (Cmd+T / typing into Terminal).
2. **System Settings → Privacy & Security → Automation**  
   - Allow Shuttle to control **Terminal** (and **iTerm** if you use it).
3. Quit Shuttle fully and reopen from **Applications**.

Avoid running the old Intel `/Applications` app and a `build/Release` copy at the same time — both share the `shuttle.Shuttle` bundle id and will fight for the menu bar / TCC grants.

### Prepare / assets

| Asset | Location | Notes |
|-------|----------|--------|
| Compiled AppleScripts | `Shuttle/apple-scpt/*.scpt` | **Committed.** Regenerate with `./apple-scripts/prepare.sh` after editing `.applescript` sources. iTerm scripts need iTerm2 installed to recompile. |
| Status bar icons | `Shuttle/StatusIcon*.png` | **Committed.** |
| App icon | `shuttle.icns` | **Committed** (project references `../shuttle.icns`). |

Individual compilers: `apple-scripts/compile-Terminal.sh`, `compile-Virtual.sh`, `compile-iTermStable.sh`, `compile-iTermNightly.sh`.

### Permissions

For `"open_in": "tab"` against Terminal.app, grant **Accessibility** to `/Applications/Shuttle.app` (System Settings → Privacy & Security → Accessibility). Automation for Terminal is also required.

## Configuration

Hosts live in `~/.shuttle.json` (a default is created on first launch). See the [original wiki](https://github.com/fitztrev/shuttle/wiki) for config help.

## License

MIT — see [LICENSE](LICENSE).

- Original work: Copyright (c) 2013 Trevor Fitzgerald
- Modifications: Copyright (c) 2026 David Engblom

## Contributors

This project was created by [Trevor Fitzgerald](https://github.com/fitztrev). Thanks to everyone who contributed upstream:

* [Alexis NIVON](https://github.com/anivon)
* [Alex Carter](https://github.com/blazeworx)
* [bihicheng](https://github.com/bihicheng)
* [Dave Eddy](https://github.com/bahamas10)
* [Dmitry Filimonov](https://github.com/petethepig)
* [Frank Enderle](https://github.com/fenderle)
* [Jack Weeden](https://github.com/jackbot)
* [Justin Swanson](https://github.com/geeksunny)
* [Kees Fransen](https://github.com/keesfransen)
* Marco Aurélio
* [Martin Grund](https://github.com/grundprinzip)
* [Matt Turner](https://github.com/thshdw)
* [Michael Davis](https://github.com/mpdavis)
* [Morton Fox](https://github.com/mortonfox)
* [Pluwen](https://github.com/pluwen)
* Rebecca Dominguez
* [Rui Rodrigues](https://github.com/rmrodrigues)
* [Ryan Cohen](https://github.com/imryan)
* [Stefan Jansen](https://github.com/steffex)
* Thomas Rosenstein
* [Thoro](https://github.com/Thoro)
* [Tibor Bödecs](https://github.com/tib)
* [welsonla](https://github.com/welsonla)

## Credits

Shuttle was inspired by [SSHMenu](http://sshmenu.sourceforge.net/), the GNOME applet for Linux.

Also see [MLBMenu](https://github.com/markolson/MLB-Menu) and [QuickSmileText](https://github.com/scturtle/QuickSmileText) for direction on building a Cocoa status-bar app.
