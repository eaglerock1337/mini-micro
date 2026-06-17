# actions & commands

How "stuff the player triggers" is modelled. One home for behavior
(`actions.ms`); two front doors into it (sim views, computer commands).

## the rule

- **`actions.ms`** — every function that *does something* lives here, as a plain
  module-as-object namespace of functions. Sim menus and computer commands both
  call into it. This is the single source of behavior.
- **`views.ms`** — sim menus reference actions by **label** (`{"Look away": @actions.lookaway}`).
- **`commands.ms`** — the computer command line references the *same* actions by
  **typed name** (`"lookaway"`). It is a flat registry both TDOS (now) and the
  GUI (later) read from.

A command is **data pointing at an action**, not a class. "Does work itself" vs
"invokes a sim action" is just which `@actions.*` funcref you store — nothing
structural changes.

## what to do with the scaffolding

| file          | action  | why                                                        |
|---------------|---------|------------------------------------------------------------|
| `command.ms`  | delete  | per-command class has no behavior to justify it            |
| `cmdData.ms`  | delete  | funcs move to `actions.ms`; metadata moves to `commands.ms`|
| `commands.ms` | rewrite | becomes a module-as-object registry (no `new`, no class)   |
| `actions.ms`  | grow    | gains the real functions (`lookaway`, `reboot`, …)         |

## commands.ms (target)

```miniscript
// commands.ms - typed computer commands -> actions  (TDOS now, GUI later)
import "actions"

list = {}
list["lookaway"] = {"desc": "look away from the screen", "action": @actions.lookaway}
list["reboot"]   = {"desc": "reboot the computer",       "action": @actions.reboot}

run = function(name)
    if not list.hasIndex(name) then return print("unknown command: " + name)
    list[name].action            // bare funcref => MiniScript calls it
end function
```

## actions.ms (target shape)

```miniscript
// actions.ms - all behavior lives here (sim views AND computer commands call in)
lookaway = function
    print "lookaway placeholder"
end function

reboot = function
    print "reboot placeholder"
end function
```

## how each caller uses it

- **TDOS command line:** read a typed string, `commands.run(typed)`.
- **GUI (later):** iterate `commands.list`, show `.desc` on each button, fire
  `.action` on click. Same registry — no second source.
- **Sim views:** keep referencing `@actions.*` directly by label.

## why this holds up

- **No import cycle.** `commands` imports `actions`; `actions` imports nothing
  back (it reads globals like `sim`/`tm` at call time). So `@actions.lookaway`
  resolves cleanly at load — no runtime wrapper needed.
- **Future metadata is free.** Capability gating / realtime cost (the TBDs) are
  just more keys on the same map: `{desc, action, needs, secs}`. Still data,
  still no class.

## also fix (independent bugs in current scaffold)

- `view.ms` action loop prints `action.key` / `action.description`; iterating a
  map yields `{key, value}` pairs and the values are bare funcrefs with no
  `.description`. Print `action.key` only — the label *is* the description.
