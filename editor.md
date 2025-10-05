# Editor Configuration for QMK Userspace

## Problem

When opening QMK source files in Zed (or other editors), you may see errors like:
- `qp.h not found`
- `quantum.h not found`
- Other QMK header files showing as missing

The project compiles perfectly with QMK, but the editor shows false positive errors because it doesn't know where the QMK firmware headers are located.

## Solution

The solution is to configure your editor's language server (clangd) to know where to find the QMK headers.

### Configuration File: `.clangd`

The `.clangd` file in the root of this userspace tells the language server:
1. Where to find QMK firmware headers
2. Where to find your userspace files
3. Which compiler warnings to suppress
4. Which diagnostics to disable

### What's Configured

The `.clangd` file includes paths to:
- **Vial QMK root**: `/Users/alfred/Projects/vial-kb/vial-qmk`
- **Quantum subsystem**: For core QMK functionality
- **Painter subsystem**: For graphics/display APIs (like `qp.h`)
- **Drivers**: For hardware drivers
- **Libraries**: Third-party libraries used by QMK
- **Platforms**: MCU-specific code
- **TMK Core**: Low-level keyboard matrix scanning
- **Userspace**: Your custom modules and code

### After Changes

After modifying `.clangd`, you need to restart your editor's language server:

**In Zed:**
1. Open command palette: `Cmd+Shift+P`
2. Type and select: "zed: restart language server"
3. Or simply restart Zed

**In VS Code:**
1. Open command palette: `Cmd+Shift+P`
2. Type and select: "C/C++: Restart IntelliSense"

### Verification

After restarting, open a file like `users/halcyon_modules/splitkb/hlc_tft_display/graphics/numbers/2.qgf.c` and verify that:
- `#include <qp.h>` no longer shows an error
- Hover over QMK functions shows documentation
- Go-to-definition works for QMK functions

## Alternative: compile_commands.json

Another approach (not used here due to build issues) is to generate a `compile_commands.json` file:

```bash
qmk compile -kb your_keyboard -km your_keymap --compiledb
```

This file contains the exact compiler commands used during build, which editors can use to understand your project. However, this requires a successful build in the QMK firmware directory, not just the userspace.

## Notes

- The paths in `.clangd` are absolute and specific to this machine
- If you move your QMK installation, update the paths in `.clangd`
- If collaborating, each developer may need their own `.clangd` with their paths
- Consider adding `.clangd` to `.gitignore` if paths differ between team members