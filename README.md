# fprime-stress-reference

Reference F Prime deployment that exercises the [`fprime-stress`](https://github.com/JPL-Devin/fprime-stress)
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
and installs `requirements.txt` (F Prime framework deps + the
`fprime-get-doom` CLI from `lib/fprime-stress/tools/fprime-get-doom`).

### Upgrade to the fprime-gds alpha

The 35 Hz x 80-chunk-per-frame DOOM downlink depends on throughput /
latency improvements that only ship in the alpha release. Bump
`fprime-gds` past the framework's `==4.2.1` pin once (pinned to the
tested alpha for reproducibility):

```sh
pip install fprime-gds==4.2.2a4
```

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

### Install the GDS plugin and start the GDS

```sh
# From the project root, one-shot install of the doom-display addon:
lib/fprime-stress/gds-plugin/install.sh

# Start the GDS - it auto-launches the FSW binary, opens the GUI on
# http://127.0.0.1:5001, and loads the project-local fprime-gds.yml
# which turns on the Dashboard tab (the doom-display addon itself is
# registered by install.sh above).
fprime-gds -d FprimeStressReference/ReferenceDeployment
```

For cross-compiled deployments or runs from a different working
directory, override the WAD path explicitly with `-w` on the binary
or pass `--app <path>` to fprime-gds.

`install.sh` copies the `doom-display` Vue addon into the active
fprime-gds package and registers it in `enabled.js`. The dashboards
feature flag (`config.enableDashboards`) is not touched - that is
flipped per-project by the `fprime-gds.yml` at the project root,
which points the GDS at `lib/fprime-stress/gds-plugin/config.js` via
its `flask.JS_CONFIGURATION_FILE` override. The same `fprime-gds.yml`
also sets the GUI/IP/TTS ports, so a plain invocation just works:

```sh
fprime-gds
```

With the GDS open, click **Dashboard** in the nav, then
**Upload Dashboard File**, and select
`lib/fprime-stress/gds-plugin/dashboard.xml`. Then dispatch the
`DoomSubtopology.doom.Start` command from the GDS **Commanding**
tab — the engine does not start on its own — or launch the binary
with `-S` to auto-start it. The DOOM panel begins rendering frames
once the engine is started.

## License

This deployment is distributed as a combined work under the **GNU
General Public License version 2 (GPLv2)** because it statically
links against the doomgeneric source from `lib/fprime-stress`, which
is itself GPLv2. See [`LICENSE`](LICENSE) for the full notice and the
`lib/fprime-stress/THIRDPARTY/` directory for the upstream attribution
and the per-component license summary.
