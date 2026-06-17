# tmsim architecture

This doc covers the **code structure** of tmsim — the globals, classes, control
flow, and conventions. For the game design (story, mechanics, phases) see
[NOTES.md](NOTES.md). Phase 1 builds a subset of what's here; the structure is
laid out so later systems (events, GUI, D.O.C., hall of fame, hardware repair)
slot in without reworking the core.

Items marked **(TBD)** are still fluid and may change as the design firms up.

## design principles

- **Simple, elegant, readable.** Clarity beats cleverness. The style reference is
  `disk/learn/battle.ms` — map-based OOP, well-known globals, no ceremony.
- **MiniScript-native OOP.** "Classes" are maps with methods on `self`,
  instantiated with `new`. Shallow prototype chains, composition over deep
  inheritance.
- **Globals are fine for game state.** A small, named set of well-known globals
  (`player`, `tm`, `sim`, `tdos`, `date`) rather than passing everything around.
- **No needless abstraction.** Patterns (state machine, factory) only when they
  genuinely earn their keep on a tiny runtime.
- **Single source of truth.** Skill/failure rolls live in one place (`dice`),
  date math in one place (`date`), save encoding in one place (`savefile`).

## three control loops

The game is three nested loops, each with a distinct job and a distinct sense of
time:

```
game.ms   OUTER / META loop  — no active sim; menus only
   |  new / load game -> enter sim
   v
sim.ms    SIMULATOR loop      — the adventure; game-time accurate to the MINUTE,
   |                            advances in quick chunks per action
   |  "look at screen" view -> enter TDOS
   v
tdos.ms   TDOS loop           — the in-world computer; REALTIME to the SECOND,
   ^                            off the Mini Micro `time` module
   |  "look away" -> reconcile elapsed time, back to sim loop
   ^  pause -> back to outer loop
```

- **Outer (`game.ms`)** never runs sim actions — it's menus/meta only.
- **Sim (`sim.ms`)** is the adventure: minute-accurate, time jumps per action,
  giving the fast "adventure" feel.
- **TDOS (`tdos.ms`)** is the realistic computer terminal: second-accurate,
  commands take real time you must wait through, giving the "simulator" feel.

## top-level globals

| global   | class       | owns                                                        |
|----------|-------------|-------------------------------------------------------------|
| `player` | Player      | stats (the 6), level, exp, health/hunger/thirst, rolls      |
| `tm`     | TimeMachine | energy, currentYear/targetYear, all Parts + ordered lists   |
| `sim`    | Sim         | session state + simulator loop; `sim.actions`, `sim.views`  |
| `tdos`   | TDOS        | realtime computer-interface state + loop (TUI for now)      |
| `date`   | Date        | single source of date/day math (day increment, etc.)        |

One active game lives in memory at a time. Loading a game repopulates these
globals; a fresh game resets them to defaults.

## module & naming convention

`import "foo"` runs `foo.ms` and collects its globals into a map named `foo` —
**the module variable equals the filename**. So nested access is the norm
(`new turtle.Turtle` from the system turtle lib). That nesting is also what
produced the awkward `new TimeMachine.TimeMachine` in early throwaway code. We
resolve it with two tiers:

**Filenames are always lowercase** (`tm.ms`, `part.ms`, `sim.ms`) — this kills
the `Foo.Foo` double-name.

**Singletons (one per game) are module-as-object** — no class, no `new`. The file
*is* the global; state and methods are module globals, and `self` binds to the
module when called (`tm.travel`). This also avoids a `tm = new TimeMachine` name
collision with the module variable. `init` resets for a new game; `fromMap` loads
saved state into the same map (no reference swapping). Applies to `player`, `tm`,
`sim`, `tdos`, `date`.

```
// tm.ms  ->  global `tm`
import "part"

energy = 0

init = function          // reset for a new game
    self.energy = 0
    self.currentYear = 2026
    self.fluxCapacitor = (new part.Part).init("Flux Capacitor")
    // ... build the other named parts
end function

travel = function
    self.energy = self.energy - cost
end function
```

Use: `import "tm"` then `tm.init`, `tm.travel`, `tm.fluxCapacitor.addWear 0.1`.

**Multi-instance things are a Capitalized class in a lowercase file**, created
with `new module.Class` (optionally aliased `Part = part.Part` at the top of a
hot file). This matches the `new turtle.Turtle` system idiom. Applies to `Part`
(the time machine owns many).

```
// part.ms  ->  class part.Part
Part = {}
Part.init = function(name)
    self.name = name
    self.wear = 0
    self.tear = 0
    return self          // chain: (new part.Part).init("Flux Capacitor")
end function
Part.addWear = function(amt)
    self.wear = self.wear + amt
end function
```

**Namespaces hung on a singleton** (`sim.actions`, `sim.views`): `actions.ms` and
`views.ms` are module-as-object namespaces of functions; `sim.init` attaches them
(`self.actions = actions`). Action functions read the global `sim` at runtime, so
there's no import cycle.

## the loops in detail

### `game.ms` — outer menu loop (meta)

Runs when no simulator is active. Pure menus/meta:

- **Profile select.** Only the profile choice is saved per minidisk.
- **Save / load** active games.
- **Hall of Fame + game history.** A separate game-history save file catalogs
  every game played, with a per-game synopsis to look back on the adventures.
- **Save options.** Opt in to keeping saves + history for the hall of fame; tools
  to pick a disk location (eases upgrading the game later).
- **Config menu** appears automatically when configuration is missing — manage
  profiles, view game history, view the hall of fame.

### `sim.ms` — simulator loop

The adventure layer. Holds loose session state (aggro, score, difficulty,
current view, rng seed, and `sim.screenTime` — see TDOS below). Time here is
**minute-accurate**; actions advance time in quick chunks (minutes to hours).

- **`sim.actions.*`** (`actions.ms`): e.g. `sim.actions.gatherWood`. Every action
  costs time and may trigger an event. `sim.actions.tdos` is the special one that
  reconciles a TDOS session (below).
- **`sim.views.*`** (`views.ms`): `inside` (cockpit), `controlPanel`, provisions,
  `outside`, `computer`, and later `modernTown`, `medievalVillage`, etc. Each view
  exposes the actions available from it.
- **events.ms**: event tables keyed by time period; actions roll against them.
  Time periods may be grouped **(TBD)** depending on how deep this goes.

### `tdos.ms` — realtime computer loop

Entered from the "look at screen" view. This is a distinct loop because it runs
**realtime to the second**, off the Mini Micro `time` module (the same clock the
sim uses to measure elapsed time). It makes the in-world computer feel real.

- **On entry**, snapshot `sim.screenTime` (a `time` timestamp) and start at a
  random second within the current minute, then tick forward. The delta gives
  game time to the second. The display shows date + time to the second.
- Precise time shows **only when the computer is healthy**; degraded hardware
  falls back to approximate time (also the MVP behavior).
- **"Look away"** preserves the `tdos` global state and returns to the sim loop.
  The sim then runs `sim.actions.tdos`, which folds the elapsed real time into
  game time and processes events + survival ticks (hunger, thirst, etc.).
- Commands run in realtime (reports, D.O.C. "churn") for a waiting feel — you
  **cannot look away while something is in progress**.
- **TUI** allows one command at a time (Phase 1). **GUI (TBD)** will allow
  multiple panes; the TDOS loop branches on TUI vs GUI.
- **Capability gating (TBD).** GUI mode and intensive D.O.C. commands require
  enough CPUs (plus NPUs for the heaviest D.O.C. work). As modules fail, fewer
  commands are available.
- Current time and the time travelled to both feed **aggro**.

## parts & hardware

Every component of the time machine is a **Part**:

- `wear` (unrepairable) and `tear` (repairable) multiply into overall condition;
  the part also accumulates **runtime**. Condition degrades with runtime, scaled
  by difficulty, and a part's **fail chance derives from its condition**.
- Methods: `addWear` / `addTear`, condition transitions OK -> Info -> Warn ->
  Fault, and a fail roll routed through `dice`.

Parts are owned by `tm` and targeted by name — `tm.airlock.open`,
`tm.fluxCapacitor.addWear(...)`. `tm` also keeps ordered aggregate lists
(critical / aux / outdoor / etc.) holding references to those parts, for views
and status sweeps.

The **Computer** (`computer.ms`) is a composite part made of swappable modules:

- redundant modules — CPUs, RAM chips, NPUs — where losing one of many degrades
  capability rather than killing the system;
- critical modules — backplane, hardware-interface module, system clock, storage —
  whose loss takes the computer down.

Use can break things: a taxing TDOS command may break a component, raising a TDOS
error that forces a "look away". **Repair** happens only when the system is off —
easy modes carry spare modules to swap in; harder modes require **soldering**
(Engineering skill) from an always-sufficient supply of spare basic electronics.
The depth of the soldering/repair minigame is **(TBD)**.

## file map

```
lib/
  game.ms       outer menu loop: profiles, save/load, hall of fame, history, config
  sim.ms        Sim — simulator loop + session state (minute-accurate)
  actions.ms    sim.actions.* — cost time, can trigger events
  views.ms      sim.views.* — inside / controlPanel / provisions / outside / computer / ...
  events.ms     event tables by time period; rolled by actions
  tdos.ms       TDOS realtime loop (second-accurate); TUI now, GUI later; D.O.C.
  player.ms     Player -> global player
  tm.ms         TimeMachine -> global tm; owns Part instances + ordered lists
  part.ms       Part — wear/tear/runtime/condition; addWear/addTear; fail rolls
  computer.ms   Computer composite part (CPU/RAM/NPU/backplane/clock/storage...)
  date.ms       Date — single source of date/day math; feeds aggro
  dice.ms       roll engine — check(stat, difficulty) -> success + degree
  difficulty.ms presets (energy mult, start year, aggro/fail/degrade rates, part set)
  savefile.ms   globals <-> disk; profile-per-minidisk; game-history catalog file
  views/        (optional split if views.ms grows: per-view render files)
```

## save / load

- One active game in memory; loading overwrites the globals, a fresh game resets
  them to defaults.
- Mini Micro ships a `json` standard lib, so saving is `json` over each global's
  `toMap` output, and loading is `fromMap` back into the same global maps.
- The save walks `player`, `tm`, `sim` (loose state), `tdos` state, and `date`.
- `savefile.ms` is the only place that knows the on-disk format, so it can change
  without touching the model.

## phase roadmap

**Phase 1 (foundations):** `player`, `tm`, `part` (wear/tear/condition + basic
runtime), the `sim` loop, basic `sim.views` plus a few `sim.actions`, a minimal
`dice` and `difficulty`, the `tdos` TUI core, `date`, and `savefile` (save/load
swapping globals, profile select) — with debug commands to test time travel and
part breakage.

**Later:** hall of fame + synopses, the full event system, GUI mode, NPU-gated /
full D.O.C., computer module breakage + soldering repair, grouped time periods,
and the degraded approximate-time display polish.
