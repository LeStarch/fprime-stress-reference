# fprime-doom

One-shot launcher for running the fprime-stress-reference deployment
under YAMCS with the DOOM web display:

```sh
fprime-doom
```

It wraps [`fprime-yamcs`](https://github.com/fprime-community/fprime-yamcs)
and, from the project checkout, automatically:

- resolves the built deployment binary and JSON dictionary under
  `build-artifacts/`,
- fetches the shareware WAD with `fprime-get-doom` if it is missing,
- loads the `doom-display` yamcs-web extension from
  `lib/fprime-stress/yamcs-plugin/`,
- marks the `DoomSubtopology.frameTlmProcessor.FrameRow*` / `PaletteOut` channels
  realtime-only so the ~9 MB/s frame stream is never archived,
- launches the flight software alongside YAMCS.

Open http://localhost:8090, click the floating **DOOM** button, press
**Start**, and click the canvas to play. The panel also offers
**Reset** (back to the boot title screen) and **Record/Stop
Recording** (download sent commands as an F Prime `.seq` file).
Requires JDK + Maven (`mvn`) on the PATH (fprime-yamcs requirement).

Options: `--no-app` skips launching the flight software (attach your
own); `--project-root DIR` overrides checkout auto-detection; all
other arguments are forwarded to `fprime-yamcs`.
