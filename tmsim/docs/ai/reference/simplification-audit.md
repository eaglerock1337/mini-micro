# simplification audit

Repo-wide over-engineering pass, ranked biggest cut first. Separate from the
command/cmdData rework — see [actions-commands.md](actions-commands.md) for that.
Reference notes; implement as time allows.

## 1. parts.ms — table-driven instead of 97 lines of field assignment

Add a `Part.init(name, shortName, conditions)` that returns `self` (same
`.init`-returning-`self` style as the actions-commands `Part`/command work),
then build parts from a table instead of `new part.Part` + per-field lines:

```miniscript
// part.ms
Part.init = function(name, shortName, conditions = null)
    self.name = name
    self.shortName = shortName
    if conditions != null then self.conditions = conditions
    self.wear = 0.0
    self.tear = 0.0
    self.condition = "off"
    self.faulty = false
    return self
end function
```

```miniscript
// parts.ms
critical = [
    ["Power Distrib. Unit", "PwrUnit"],
    ["Control Panel",       "CtrPanl"],
    ["Life Support",        "LifSupp"],
    ["Cabin Airlock",       "Airlock", ["opn", "lck"]],
    // ...
]
Parts.critical = []
for row in critical
    if row.len > 2 then c = row[2] else c = null
    Parts.critical.push (new part.Part).init(row[0], row[1], c)
end for
```

- `Parts.critical` / `Parts.auxillary` become plain arrays built once, not
  getters that rebuild a list from named fields every call.
- Named access (`Parts.FluxCapacitor`) is only used by those getters today, so
  it can go. If a few parts need direct references later, alias just those.
- Side benefit: kills the `self.Airlock` vs `self.AirLock` casing bug in the
  current `criticalParts` getter.

~-50 lines.

## 2. sim.ms view dispatch duplicates views.ms / view.ms

`sim.ms` has inline view stubs (`console`, `dashboard`, `control`, `inside`,
`outside`) plus a `viewList` map, while `views.ms`/`view.ms` build a separate
`Views`/`View` registry with the same `inside`/`outside` names. Two registries
for one concept — the same duplication the actions-commands doc resolves. Pick
one (the `views.ms` registry) and have `sim` dispatch through it. ~-20 lines.

## 3. ~~datetime.ms is a dead stub~~ DONE

Replaced by `clock.ms`, which wraps `_dateVal`/`_dateStr` intrinsics directly.
No `import "dateTime"` needed.

## 4. Parts.externalParts / internalParts return []

Empty placeholders. Delete until something fills them. ~-4 lines.

## 5. test / load-print debug stubs

Scaffolding noise that proves nothing: `actions.test`, `Clock.test`,
`Stats.init` (only prints), and call sites like `sim.run`
calling `actions.test`. Remove as the real code lands. ~-12 lines.

## 6. two bootstraps

`tmsim.ms` (sets `debug`, imports all singletons, calls `game.init`/`game.run`)
and `startup.ms` overlap. `startup.ms` calls `game.tmsim.run`, which doesn't
exist on `game`. Collapse to one entrypoint: `startup.ms` sets up import paths
then `import "tmsim"` rather than re-implementing boot. ~-5 lines, also fixes
the broken call.

## intentionally NOT cut

`screen.ms` display accessors (`consoleBody = function; return display(0); ...`)
look like delegating wrappers but they re-fetch `display(n)` on each call —
correct, because changing a layer's `displayMode` swaps the underlying display
object. Caching them at load would be the flimsier choice. Leave them.

---

net: ~-95 lines, 0 deps. Items 1 and the actions-commands `Part.init` are the
same constructor style — worth doing in one pass.
