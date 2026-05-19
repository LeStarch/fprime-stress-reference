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
pip install -r requirements.txt
```

This pulls in F Prime's own requirements (fprime-tools, fprime-gds,
fprime-fpp) and installs the `fprime-get-doom` CLI from
`lib/fprime-stress/tools/fprime-get-doom`.

### Fetch the shareware DOOM WAD

```sh
fprime-get-doom -o doom1.wad
```

`doom1.wad` is the freely-distributable shareware demo from
id Software. See the `lib/fprime-stress` README for the licensing
discussion.

### Build the deployment

```sh
cd FprimeStressReference/ReferenceDeployment
fprime-util generate
fprime-util build
```

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
# From the project root:
./build-fprime-automatic-native/bin/Linux/FprimeStressReference_ReferenceDeployment \
    -a 127.0.0.1 -p 50000 -w doom1.wad
```

Then point `fprime-gds` at the deployment and load the
`doom-display` JS plugin from `lib/fprime-stress/gds-plugin/` to see
DOOM render in the GDS dashboard.

## License

This deployment is distributed as a combined work under the **GNU
General Public License version 2 (GPLv2)** because it statically
links against the doomgeneric source from `lib/fprime-stress`, which
is itself GPLv2. See [`LICENSE`](LICENSE) for the full notice and the
`lib/fprime-stress/THIRDPARTY/` directory for the upstream attribution
and the per-component license summary.
