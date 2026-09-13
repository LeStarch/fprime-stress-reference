# fprime-stress-reference — guide for AI agents and reviewers

Deployment consuming `lib/fprime-stress`. Follow `lib/fprime/AGENTS.md`
for F Prime conventions and `lib/fprime-stress/AGENTS.md` for project
rules — in particular STRESS-1: operation outcomes (return statuses,
event arguments, telemetry) are FPP enumerations, not `bool`. Reviewers
flag `bool` statuses as must-fix (`stress-bool-status`).

Do not edit `lib/fprime` or `lib/fprime-stress/Doom/DoomEngine/doomgeneric`
(submodules); change the FPP model, not generated `*Ac.hpp/.cpp`.

## Commands

```bash
source fprime-venv/bin/activate
fprime-util generate && fprime-util build -j"$(nproc)"
fprime-util check -j"$(nproc)"
fprime-doom   # launches YAMCS + deployment
```
