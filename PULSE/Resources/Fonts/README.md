# PULSE App Fonts

Place the app-wide font files for PULSE in this directory.

- Prefer `.ttf` or `.otf` files for native iOS font bundling.
- Include every weight/style you plan to use (for example Regular, Medium, Semibold, and Bold).
- After adding the font files, register their exact filenames in the app target's `Info.plist` under `UIAppFonts` and use the font's internal PostScript name in SwiftUI.

This directory is the shared home for typography across the entire app, not just the welcome screen.
