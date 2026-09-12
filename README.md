# fprime-stress-reference

Reference F Prime deployment that exercises the [`fprime-stress`](https://github.com/LeStarch/fprime-stress)
library by wrapping [doomgeneric](https://github.com/ozkl/doomgeneric)
inside an F Prime topology, streaming the framebuffer down as
telemetry, and driving inputs as F Prime commands.

> *But does it run DOOM?*

Yes. See the library README for the design, the architecture diagram,
and the rationale for using DOOM as a flight-software stress test.
This repository is the deployment that consumes the library and turns
it into a runnable binary.

## Project Structure

```
fprime-stress-reference/
├── CMakeLists.txt                  # root: bootstraps the F Prime build
├── README.md
├── LICENSE                         # GPLv2 (combined-work license, see notes)
├── requirements.txt                # F Prime deps + fprime-get-doom CLI
├── settings.ini                    # framework_path / library_locations
├── fprime-gds.yml                  # project-local fprime-gds defaults
├── .gitmodules
├── lib/
│   ├── fprime/                     # F Prime framework  (git submodule)
│   └── fprime-stress/              # DOOM library       (git submodule)
├── tools/
│   └── fprime-doom/                # one-shot YAMCS + DOOM launcher CLI
└── FprimeStressReference/          # project directory
    └── ReferenceDeployment/        # deployment directory
        ├── CMakeLists.txt
        ├── Main.cpp
        ├── Top/                    # topology (instances, packets, bindings)
        └── config/                 # F Prime configuration overrides
```

The `FprimeStressReference/` directory holds anything that is
project-scoped (components, ports, types). Today the only project
content is the `ReferenceDeployment` deployment because the DOOM
component itself is sourced from `lib/fprime-stress`.

## Getting Started

### Clone and bootstrap

```sh
pip install fprime-bootstrap
fprime-bootstrap clone https://github.com/JPL-Devin/fprime-stress-reference.git
cd fprime-stress-reference
. fprime-venv/bin/activate
```

`fprime-bootstrap clone` recurses submodules, creates `fprime-venv/`,
and installs `requirements.txt` (F Prime framework deps, the
`fprime-get-doom` CLI from `lib/fprime-stress/tools/fprime-get-doom`,
the `fprime-doom` YAMCS launcher, and `fprime-yamcs`).

Existing checkouts that predate the `fprime-stress` repository move to
`LeStarch/fprime-stress` should run `git submodule sync --recursive`
once to pick up the new submodule URL.

### Build the deployment

```sh
fprime-util generate
fprime-util build
```

Run from the project root; `fprime-util` discovers the deployment via
`settings.ini`.

### Fetch the shareware DOOM WAD

```sh
fprime-get-doom   # auto-discovers build-artifacts/, lands in data/
```

With no arguments, `fprime-get-doom` writes to
`build-artifacts/<platform>/<deployment>/data/doom1.wad`. When `-w`
is not given, the binary searches a small list of candidate WAD
locations (the project-rooted build-artifacts path, `./doom1.wad`,
then `../data/doom1.wad`) so it behaves the same whether
it's launched manually from the project root or auto-launched by
`fprime-gds` (which inherits the operator's working directory; see
https://github.com/nasa/fprime/issues/5185 for the upstream fix).
`doom1.wad` is the freely-distributable shareware demo from
id Software. See the `lib/fprime-stress` README for the licensing
discussion.

### Cross-compile

The standard F Prime toolchains for arm32 and arm64 work without any
project-side changes:

```sh
fprime-util generate aarch64-linux
fprime-util build    aarch64-linux

fprime-util generate arm-hf-linux
fprime-util build    arm-hf-linux
```

### Run on the YAMCS ground layer

```sh
# From the project root - installs are one-time (see tools/fprime-doom):
pip install -e tools/fprime-doom

# Launches YAMCS with the doom-display web extension and auto-starts
# the FSW binary. Open http://localhost:8090 when it is up.
fprime-doom
```

Click the floating **DOOM** button in the YAMCS web UI, then **Start**
in the panel — the engine does not start on its own. The panel renders
frames, forwards keyboard input as commands, and offers Stop/Reset.
The display size follows the compile-time `Doom.DOWNSAMPLE_FACTOR`
configured in `lib/fprime-stress/Doom/DoomConfig/DoomConfig.fpp`.

The project-local `fprime-gds.yml` still configures the python GDS
(UDP transport, CCSDS framing, ports — see "Communications" below) for
the integration test suite:

```sh
fprime-gds
```

For cross-compiled deployments or runs from a different working
directory, override the WAD path explicitly with `-w` on the binary
or pass `--app <path>` to fprime-gds.

## Communications: CCSDS TM/TC frames over UDP

The deployment uses the standard `ComCcsds.Subtopology` framing stack
(space packets aggregated into CCSDS TM transfer frames on downlink,
TC frames on uplink) riding a `Drv.Udp` transport, matching the
fprime-yamcs `UdpTmFrameLink`/`UdpTcFrameLink` links. Port
convention (shared by `fprime-gds.yml` and the binary defaults):

| Port  | Role |
|-|-|
| 50000 | ground TM listen (binary `-p` / GDS `udp-recv-port`) |
| 50001 | FSW TC listen (binary `-u` / GDS `udp-send-port`) |

## Run with YAMCS (fprime-doom)

[`fprime-yamcs`](https://github.com/fprime-community/fprime-yamcs)
launches YAMCS in lieu of the fprime-gds pipelines, converts the
F Prime JSON dictionary to XTCE at startup, and configures its UDP
frame links from the dictionary's `ComCfg` constants. Requires JDK +
Maven (`mvn`) on the PATH.

The `fprime-doom` CLI (installed by `requirements.txt` from
`tools/fprime-doom/`) wraps it with everything this deployment needs -
the doom-display web extension from `lib/fprime-stress/yamcs-plugin/`,
realtime-only filtering of the `DoomSubtopology.frameTlmProcessor.FrameRow*` /
`PaletteOut` channels (the ~9 MB/s frame stream is never archived),
WAD auto-fetch, and flight-software launch:

```sh
fprime-doom
```

Open http://localhost:8090, click the floating **DOOM** button, press
**Start**, and click the canvas to play (WASD/arrows/Space/Ctrl).
The panel also offers **Reset** (return to the boot title screen) and
**Record/Stop Recording** (download the commands you sent as an
F Prime `.seq` sequence file); the Start/Stop toggle tracks the
engine's `State` telemetry, so its label stays correct.
`fprime-doom --no-app` skips launching the flight software; other
arguments are forwarded to `fprime-yamcs`.

## License

This deployment is distributed as a combined work under the **GNU
General Public License version 2 (GPLv2)** because it statically
links against the doomgeneric source from `lib/fprime-stress`, which
is itself GPLv2. See [`LICENSE`](LICENSE) for the full notice and the
`lib/fprime-stress/THIRDPARTY/` directory for the upstream attribution
and the per-component license summary.
