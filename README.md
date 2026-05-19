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

### Clone with submodules

```sh
git clone --recursive https://github.com/JPL-Devin/fprime-stress-reference.git
cd fprime-stress-reference
```

If you already cloned without `--recursive`:

```sh
git submodule update --init --recursive
```

### Set up the Python environment

```sh
python3 -m venv fprime-venv
. fprime-venv/bin/activate
pip install -U pip
pip install --pre -r requirements.txt
```

The `--pre` flag is required because `requirements.txt` pins
`fprime-gds==4.2.2a1` (alpha release) for the polling-loop throughput
improvements the 35 Hz x 80-chunk-per-frame DOOM stream depends on.
The install also pulls F Prime's own requirements and the
`fprime-get-doom` CLI from `lib/fprime-stress/tools/fprime-get-doom`.

### Build the deployment

```sh
cd FprimeStressReference/ReferenceDeployment
fprime-util generate
fprime-util build
```

### Fetch the shareware DOOM WAD

```sh
fprime-get-doom   # auto-discovers build-artifacts/, lands in data/
```

With no arguments, `fprime-get-doom` writes to
`build-artifacts/<platform>/<deployment>/data/doom1.wad`. That is
also the path the deployment binary's default `-w` flag resolves to
(`../data/doom1.wad` relative to the binary's `bin/` dir), so a
no-flag launch from inside `build-artifacts/.../bin/` just works.
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

### Run

```sh
# From inside the deployment's bin/ dir so -w defaults work:
cd build-artifacts/Linux/FprimeStressReference_ReferenceDeployment/bin
./FprimeStressReference_ReferenceDeployment -a 127.0.0.1 -p 50100 -S
```

### Install the GDS plugin and start the GDS

```sh
# From the project root, one-shot install:
lib/fprime-stress/gds-plugin/install.sh
```

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
`lib/fprime-stress/gds-plugin/dashboard.xml`. The DOOM panel
appears and starts rendering frames as soon as the deployment binary
is sending telemetry.

## License

This deployment is distributed as a combined work under the **GNU
General Public License version 2 (GPLv2)** because it statically
links against the doomgeneric source from `lib/fprime-stress`, which
is itself GPLv2. See [`LICENSE`](LICENSE) for the full notice and the
`lib/fprime-stress/THIRDPARTY/` directory for the upstream attribution
and the per-component license summary.
