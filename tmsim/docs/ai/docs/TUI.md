# TUI reference

Reference for the TDOS text-based user interface. For game design context see
[NOTES.md](NOTES.md); for code structure see [ARCHITECTURE.md](ARCHITECTURE.md).

## display layer allocation

Mini Micro has 8 display layers (0-7), rendered back-to-front (7 = backmost,
0 = frontmost). The stock `gui` library (`gui.ms`) claims layers 2-7 via
`gui.setupDisplays`:

| Layer | gui.ms mode    | gui.ms variable   | gui.ms purpose                          |
|-------|----------------|-------------------|-----------------------------------------|
| 7     | pixel          | `scratchDisp`     | off-screen compositing (hidden behind 6)|
| 6     | solidColor     | `backgroundDisp`  | desktop background color                |
| 5     | off            | —                 | disabled (scratch in DEBUG mode only)    |
| 4     | sprite         | `spriteDisp`      | windows, scrollbar thumbs, shadows      |
| 3     | text           | `text`            | text overlay                            |
| 2     | pixel          | `menuDisp`        | menu bar and dropdown rendering         |
| 1     | **not touched** | —                | **free**                                |
| 0     | **not touched** | —                | **free**                                |

Layers 0 and 1 are never touched by gui.ms. Layer 5 is explicitly set to
`displayMode.off` in normal mode and never referenced again at runtime (only
used as `scratchDisp` when the global `DEBUG` flag is set). The TUI reclaims
layer 5 after `gui.setupDisplays` runs, giving it three layers.

### TUI layers

| Layer | Mode | Purpose |
|-------|------|---------|
| 5 | `text` | semi-static frame — borders, labels, section headers (opaque black background) |
| 1 | `text` | shared dynamic values — current time, inventory counts, part statuses |
| 0 | `text` | main screen output — scrolling console, D.O.C. sessions, alt panels |

**Layer 5** has a solid black background with lime (or themed) text for the
frame characters. Because it is opaque, it occludes gui layers 6-7 behind it.
However, gui layers 4 (sprites), 3 (text), and 2 (menus) are in front of
layer 5 and must be hidden when the TUI is active (see mode switching below).
This layer is drawn once during initialization and only updated when the frame
structure itself changes (e.g. adding new panels). Reclaimed from gui.ms, which
sets it to off and never touches it again in normal (non-DEBUG) mode.

**Layer 1** uses `color.clear` as its background so layer 5 shows through
wherever layer 1 has no content. It holds values that update frequently but
should survive a screen clear — current time display, inventory counts,
ON/OFF/OPN/WARN/FAULT part statuses. Clearing layer 0 does not affect these
values.

**Layer 0** uses `color.clear` as its background so layers 1 and 5 show through.
This is the main output surface — scrolling console, D.O.C. sessions, status
panels. It can be fully cleared and repainted from in-memory buffers at any time
without losing the frame (layer 5) or the shared dynamic values (layer 1).

### GUI layers (TDOS GUI mode — later phase)

Layers 2-4, 6-7 are reserved for TDOS GUI mode, which will use the stock `gui`
library for a windowed desktop-like environment (see [desktop.ms](desktop.ms)
for reference). Layer 5 is shared — gui.ms disables it in normal mode, and the
TUI reclaims it.

### initialization order

The gui library must be initialized first. `gui.setupDisplays` claims layers
2-7 (setting layer 5 to off). Only after that should the TUI reclaim layer 5
and set up layers 1 and 0. Reversing this order would cause `setupDisplays` to
overwrite the TUI frame layer.

```
1. gui.setupDisplays          // claims layers 2-7, sets layer 5 to off
2. set up TUI layer 5         // reclaim from gui — opaque frame
3. set up TUI layers 1, 0     // dynamic values + main output
4. hide gui layers 2-4        // they sit in front of layer 5
```

### mode switching

Transitioning between TUI and GUI is a matter of toggling layer modes. Content
persists across `displayMode.off` toggles — no redraw is needed when restoring
a layer.

Gui layers 4, 3, and 2 render in front of layer 5 (lower number = closer to
the viewer). They must be hidden when the TUI is active, otherwise gui content
would appear on top of the TUI frame.

```
enter TUI:  display(4).mode = displayMode.off    // hide gui sprites
            display(3).mode = displayMode.off    // hide gui text
            display(2).mode = displayMode.off    // hide gui menus
            display(5).mode = displayMode.text   // frame — occludes gui 6-7
            display(1).mode = displayMode.text   // dynamic values
            display(0).mode = displayMode.text   // main output

enter GUI:  display(5).mode = displayMode.off    // release back to gui
            display(1).mode = displayMode.off
            display(0).mode = displayMode.off
            display(2).mode = displayMode.pixel  // restore gui menus
            display(3).mode = displayMode.text   // restore gui text
            display(4).mode = displayMode.sprite // restore gui sprites
```

## TUI layout

The 68x26 text grid maps to the layout in [layout.txt](layout.txt). Row 25 is
the top of the screen, row 0 is the bottom (Mini Micro convention — origin is
bottom-left).

The layout has two regions:

- **left panel** (columns 0-14): inventory, critical parts, and auxiliary parts
  with status values
- **right pane** (columns 15-67): main content area used for the scrolling
  console, D.O.C. sessions, or status panels

### layer 5 — semi-static frame

All border characters (`+`, `-`, `|`), section headers (`INVENTORY`,
`CRIT-PARTS`, `AUX-PARTS`), and static labels (`Logs`, `Trash`, part names,
etc.) are drawn once on layer 5 during initialization. This layer is only
updated when the frame structure itself changes (e.g. adding new panels).

### layer 1 — shared dynamic values

Frequently updating values that should persist across screen clears: current
time display, inventory counts, part statuses (ON/OFF/OPN/WARN/FAULT). These
occupy known cell positions within the left panel and title bar. Clearing
layer 0 for a new console session or panel swap does not affect these.

### layer 0 — main screen output

The primary output surface for the right pane: scrolling console, D.O.C.
sessions, and alternate status panels. Can be fully cleared and repainted from
in-memory buffers at any time without losing the frame or dynamic values.

## scrolling console

The right pane operates as a scrolling text console backed by a line buffer (a
list of strings held in memory). A render function draws the visible tail of the
buffer into the console region of layer 0. Word-wrapping is handled before lines
enter the buffer.

Key properties:
- **region**: approximately columns 15-67, rows 1-23 (~53 chars wide, ~23 rows)
- **scrolling**: new lines push old lines up; render always shows the last N
  lines from the buffer
- **persistence**: the line buffer survives layer toggles and screen clears —
  calling render repopulates the display from memory
- **buffer cap**: bound the buffer size (e.g. 500 lines) to prevent unbounded
  growth; trim from the front when exceeded

## alternate panels (layer 0)

Layer 0 hosts alternative displays that replace the console in the right pane —
for example, a D.O.C. agent session or a detailed status panel. Swapping panels
clears the right-pane region of layer 0 and renders the new content. Each panel
maintains its own buffer so switching back restores previous state. The shared
dynamic values on layer 1 remain visible throughout.
