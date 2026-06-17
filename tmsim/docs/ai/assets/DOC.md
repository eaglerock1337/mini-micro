# D.O.C. — Character Design Reference

**D**elorean **O**perations **C**omputer — stylized after Doc Brown and the Claude Code CLI icon.

Terminal-prompt face `[>_*]`, block-element head (homage to Claude Code icon), wild ASCII hair.

---

## Design Philosophy

- **Normal/pensive state**: legit ASCII/Unicode only, should look like real terminal text
- **Emoting states**: creative liberties increase with intensity
- **Hair = energy meter**: calm → wild → doubled = mood at a glance
- **Forehead row = eyebrow canvas**: empty when calm, expressive when emoting
- **Tapered jaw**: wider forehead (bald dome), narrow chin (Doc Brown silhouette)
- **Side accents**: `──` calm, `══` intense — glasses arms / energy gauge

---

## Base Design — Option A: "Tapered Doc" (PREFERRED)

```
        \ |/ | /
      \  \|/ |/  /
        ┌─────────┐
        │         │        ← forehead / eyebrow canvas
     ── │  >   *  │ ──    ← eyes (── = glasses arms)
         \   _   /         ← mouth on its own row
          └──┬──┘
            >─<            ← bowtie
             |
```

9 rows tall, ~23 chars wide. Fits TUI display.

### Anatomy

```
        HAIR ZONE (2 rows, /\|- characters)
        ┌─────────┐   TOP OF HEAD (flat = bald dome)
        │ EYEBROW │   FOREHEAD (empty or eyebrow chars)
     ── │  EYES   │ ──  EYE ROW (side accents = glasses)
         \ MOUTH /     MOUTH ROW (tapered = jaw/chin)
          └──┬──┘      CHIN
            >─<        BOWTIE
             |         NECK/BODY STUB
```

### Face Slot Dimensions

- Head interior: 9 chars wide
- Eye row content: `  >   *  ` (9 chars between │ walls)
- Mouth row content: `   _   ` (7 chars between \ / walls)
- Eyebrow row content: 9 chars between │ walls

---

## Base Design — Option B: "Rounded Terminal" (COMPACT)

```
        \ |/ | /
      \  \|/ |/  /
        ╭───────╮
     ── │ >   * │ ──
        │   _   │
     ── ╰───┬───╯ ──
           >─<
            |
```

8 rows tall, ~21 chars wide. No eyebrow row; simpler but less expressive.

---

## Expressions

### NORMAL — default idle state
```
        \ |/ | /
      \  \|/ |/  /
        ┌─────────┐
        │         │
     ── │  >   *  │ ──
         \   _   /
          └──┬──┘
            >─<
             |
```
Eyebrows: none | Eyes: `>   *` | Mouth: `_` | Hair: standard | Side: `──`

### TALKING — alternate frames A / B
```
  Frame A (mouth open)          Frame B (mouth closed)

        \ |/ | /                      \ |/ | /
      \  \|/ |/  /                  \  \|/ |/  /
        ┌─────────┐                  ┌─────────┐
        │         │                  │         │
     ── │  >   *  │ ──           ── │  >   *  │ ──
         \   o   /                    \   _   /
          └──┬──┘                      └──┬──┘
            >─<                          >─<
             |                            |
```
Cycle on timer. Add slight Y-bob for liveliness.

### SURPRISED — classic O_O
```
        \ |/ | /
      \  \|/ |/  /
        ┌─────────┐
        │  /   \  │
     ── │  O   O  │ ──
         \   _   /
          └──┬──┘
            >─<
             |
```
Eyebrows: `/   \` (raised) | Eyes: `O   O` | Mouth: `_`

### DISAPPROVAL — ಠ_ಠ style
```
        \ |/ | /
      \  \|/ |/  /
        ┌─────────┐
        │  _   _  │
     ── │  ಠ   ಠ  │ ──
         \   _   /
          └──┬──┘
            >─<
             |
```
Eyebrows: `_   _` (heavy/flat) | Eyes: `ಠ   ಠ` | Mouth: `_`

ASCII fallback if ಠ unavailable: `@   @`

### ANGRY — V-brows, high energy
```
     \\ \ |/ | / //
      \\ \|/ |/ //
        ┌─────────┐
        │  \   /  │
     ══ │  >   ! │ ══
         \   #   /
          └──┬──┘
            >─<
             |
```
Eyebrows: `\   /` (V-shaped) | Eyes: `>   !` | Mouth: `#` (gritted) | Hair: doubled | Side: `══`

### YELLING — angry + wide open mouth
```
     \\ \ |/ | / //
      \\ \|/ |/ //
        ┌─────────┐
        │  \   /  │
     ══ │  >   ! │ ══
         \  OOO  /
          └──┬──┘
            >─<
             |
```
Eyebrows: `\   /` | Eyes: `>   !` | Mouth: `OOO` (wide open) | Hair: doubled | Side: `══`

### HAPPY — ^_^ classic
```
      /\ \ |/ /\
       \  \|/ /
        ┌─────────┐
        │         │
     ── │  ^   ^  │ ──
         \   v   /
          └──┬──┘
            >─<
             |
```
Eyebrows: none | Eyes: `^   ^` | Mouth: `v` | Hair: bouncy (curled tips)

### CONFUSED — deflated, questioning
```
             ?
          \  |  /
        ┌─────────┐
        │         │
     ── │  >   ?  │ ──
         \   ~   /
          └──┬──┘
            >─<
             |
```
Eyebrows: none | Eyes: `>   ?` | Mouth: `~` (wavy) | Hair: droopy/sparse

### THINKING — pensive + thought bubble
```
        \ |/ | /      o
      \  \|/ |/  /  O
        ┌─────────┐
        │         │
     ── │  >   *  │ ──
         \   .   /
          └──┬──┘
            >─<
             |
```
Eyebrows: none | Eyes: `>   *` | Mouth: `.` (pensive) | Thought bubble: `o O`

---

## Expression Quick Reference

| State       | Brows   | Eyes    | Mouth | Hair     | Side | Emoticon |
|-------------|---------|--------|-------|----------|------|----------|
| Normal      | —       | `> *`  | `_`   | standard | `──` | `>_*`    |
| Talking A   | —       | `> *`  | `o`   | standard | `──` | `>o*`    |
| Talking B   | —       | `> *`  | `_`   | standard | `──` | `>_*`    |
| Surprised   | `/ \`   | `O O`  | `_`   | standard | `──` | `O_O`    |
| Disapproval | `_ _`   | `ಠ ಠ`  | `_`   | standard | `──` | `ಠ_ಠ`    |
| Angry       | `\ /`   | `> !`  | `#`   | doubled  | `══` | `>#!`    |
| Yelling     | `\ /`   | `> !`  | `OOO` | doubled  | `══` | `>O!`    |
| Happy       | —       | `^ ^`  | `v`   | bouncy   | `──` | `^v^`    |
| Confused    | —       | `> ?`  | `~`   | droopy   | `──` | `>~?`    |
| Thinking    | —       | `> *`  | `.`   | standard | `──` | `>.*`    |

---

## Hair Variants

### Standard (calm)
```
        \ |/ | /
      \  \|/ |/  /
```

### Doubled (angry/intense)
```
     \\ \ |/ | / //
      \\ \|/ |/ //
```

### Bouncy (happy/excited)
```
      /\ \ |/ /\
       \  \|/ /
```

### Droopy (confused/sad)
```
             ?          (or without ?)
          \  |  /
```

### Standing (shocked) — alt for surprised
```
       | | | | |
       | | | | |
```

---

## Animation Notes

- **Talking**: cycle mouth `_` → `o` → `_` on timer. Add Y-bob (spr.y ±1).
- **Angry escalation**: normal → angry → yelling (progressive)
- **Spin**: spr.rotation for comedic full spin when frustrated
- **Scale pulse**: spr.scale 1.0 → 1.1 → 1.0 for emphasis/shouting
- **Idle bob**: subtle spr.y oscillation ±1px on slow timer
- **Thought bubble**: separate sprite, float upward and fade

---

## Useful Characters — Borders & Box Drawing

### Box Drawing (light)
```
┌ ─ ┐    corners + horizontal
│   │    vertical
└ ─ ┘    corners + horizontal
├ ┤      T-junctions (side)
┬ ┴      T-junctions (top/bottom)
┼        cross
```

### Box Drawing (heavy)
```
┏ ━ ┓
┃   ┃
┗ ━ ┛
┣ ┫ ┳ ┻ ╋
```

### Box Drawing (double)
```
╔ ═ ╗
║   ║
╚ ═ ╝
╠ ╣ ╦ ╩ ╬
```

### Box Drawing (rounded corners)
```
╭ ─ ╮
│   │
╰ ─ ╯
```

### Block Elements
```
█  FULL BLOCK
▀  UPPER HALF       ▄  LOWER HALF
▌  LEFT HALF        ▐  RIGHT HALF
▛  UPPER LEFT + UPPER RIGHT + LOWER LEFT
▜  UPPER LEFT + UPPER RIGHT + LOWER RIGHT
▙  UPPER LEFT + LOWER LEFT + LOWER RIGHT
▟  UPPER RIGHT + LOWER LEFT + LOWER RIGHT
▘  UPPER LEFT       ▝  UPPER RIGHT
▖  LOWER LEFT       ▗  LOWER RIGHT
░  LIGHT SHADE      ▒  MEDIUM SHADE      ▓  DARK SHADE
```

### Claude Code Icon (reference)
```
 ▐▛███▜▌
▝▜█████▛▘
  ▘▘ ▝▝
```

### Arrows & Triangles
```
▲ ▼ ◄ ►    solid triangles
△ ▽ ◁ ▷    outline triangles
← → ↑ ↓    arrows
↖ ↗ ↘ ↙    diagonal arrows
⇐ ⇒ ⇑ ⇓    double arrows
```

### Misc Symbols
```
● ○ ◉ ◎    circles
■ □ ◆ ◇    squares/diamonds
★ ☆         stars
♠ ♣ ♥ ♦    card suits
✓ ✗ ✘       checks/crosses
⚡ ⚙ ⚠       lightning, gear, warning
… · •       ellipsis, middle dot, bullet
─ │ ╱ ╲     line segments
```

### Classic Emoticon Eyes
```
>   prompt/chevron (D.O.C. default left eye)
*   asterisk (D.O.C. default right eye)
^   happy/closed
O   surprised/wide
@   staring/judging
ಠ   disapproval (Kannada letter, U+0CA0)
¬   side-eye / not-amused
~   confused/wavy
?   questioning
!   alarmed
```

### Classic Emoticon Mouths
```
_   neutral/flat
o   talking/open
O   yelling/wide open
#   gritted/angry
~   confused/wavy
v   smile
.   pensive/thinking
D   big grin (for >D< excited face)
```

---

## Sprite Implementation (Mini Micro)

Each expression = one frame rendered onto an Image.

```
// pseudocode
frames = {}
frames["normal"]   = renderDOC(eyes:"> *", mouth:"_", brows:"", hair:"standard")
frames["talk_a"]   = renderDOC(eyes:"> *", mouth:"o", brows:"", hair:"standard")
frames["talk_b"]   = frames["normal"]
frames["angry"]    = renderDOC(eyes:"> !", mouth:"#", brows:"\ /", hair:"doubled")
frames["surprise"] = renderDOC(eyes:"O O", mouth:"_", brows:"/ \", hair:"standard")
// etc.

doc = new Sprite
doc.image = frames["normal"]
display(4).sprites.push doc

// animation loop
while true
    if talking then
        doc.image = frames["talk_" + (tick % 2 == 0 ? "a" : "b")]
        doc.y = baseY + sin(tick * 0.3)  // bob
    end if
    yield
end while
```

---

## References

- Claude Code CLI icon: `▐▛███▜▌` / `▝▜█████▛▘` / `▘▘ ▝▝`
- Doc Brown (Back to the Future): wild side hair, tall forehead, lab coat, bowtie
- Terminal prompt aesthetic: `$ > _ █ ▮ ▯`
- Classic emoticons: `O_O` `^_^` `ಠ_ಠ` `>_<` `¬_¬`
