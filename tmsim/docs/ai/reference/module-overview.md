# module overview

How each file is structured and why.

## singleton modules

Imported once, cached by MiniScript. No `new`, no class. State lives at
module level.

| file          | purpose                                              |
|---------------|------------------------------------------------------|
| `tmsim.ms`    | entry point — sets globals, imports everything, runs `game` |
| `game.ms`     | main menu loop (`game.init`, `game.run`)             |
| `sim.ms`      | simulator loop, view switching, sim state (times, paused) |
| `tdos.ms`     | computer OS loop, imports `commands`/`console`       |
| `screen.ms`   | display layer setup, mode switching                  |
| `gruvbox.ms`  | color constants                                      |
| `tm.ms`       | time machine state                                   |
| `player.ms`   | player character state                               |
| `actions.ms`  | all behavior functions (shared by views + commands)  |
| `commands.ms` | string-to-action registry, only used by tdos         |
| `views.ms`    | sim view definitions, references `actions.*` by funcref |
| `stats.ms`    | player or machine stats                              |

## classes (multiple instances)

Used where you need more than one instance of something.

| file          | class     | purpose                                    |
|---------------|-----------|--------------------------------------------|
| `view.ms`     | `View`    | individual view instance (label-to-action menus) |
| `console.ms`  | `Console` | console/TUI instance, created by tdos      |
| `time.ms`     | `Time`    | date/time instances (`new time.Time`)      |
| `datetime.ms` | —         | date/time support                          |
| `part.ms`     | `Part`    | individual time machine part               |
| `parts.ms`    | —         | part definitions/collection                |

## planned deletions

| file         | reason                                                |
|--------------|-------------------------------------------------------|
| `command.ms` | per-command class wrapper, unnecessary                 |
| `cmdData.ms` | functions move to `actions.ms`, metadata to `commands.ms` |
