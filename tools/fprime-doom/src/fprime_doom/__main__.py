""" fprime-doom: one-shot DOOM-over-YAMCS launcher.

Wraps fprime-yamcs with everything the fprime-stress-reference
deployment needs:

- loads the doom-display yamcs-web extension from lib/fprime-stress,
- keeps the high-rate frame/palette telemetry realtime-only (never
  archived, never parameter-cached),
- launches the flight software binary alongside YAMCS,
- fetches the shareware WAD first if it is missing.

Run from anywhere inside the fprime-stress-reference checkout:

    fprime-doom
"""
import argparse
import os
import subprocess
import sys
import tempfile
from pathlib import Path

# Channels that must flow in and out of YAMCS without being archived.
REALTIME_ONLY_CHANNELS = [
    "DoomSubtopology.frameTlmProcessor.FrameRow*",
    "DoomSubtopology.frameTlmProcessor.PaletteOut",
]
WEB_EXTENSION_RELATIVE = Path("lib/fprime-stress/yamcs-plugin/doom-display")
DEPLOYMENT_NAME = "FprimeStressReference_ReferenceDeployment"


def find_project_root(start: Path) -> Path:
    """ Walk up from start to the directory containing settings.ini """
    for candidate in [start] + list(start.parents):
        if (candidate / "settings.ini").is_file() and (candidate / "lib" / "fprime-stress").is_dir():
            return candidate
    raise SystemExit(
        "[ERROR] Not inside an fprime-stress-reference checkout (no settings.ini found). "
        "Run from the project root or pass --project-root."
    )


def find_deployment_dir(project_root: Path) -> Path:
    """ Locate the build-artifacts deployment directory for the host platform """
    artifacts = project_root / "build-artifacts"
    matches = sorted(artifacts.glob(f"*/{DEPLOYMENT_NAME}"))
    if not matches:
        raise SystemExit(
            f"[ERROR] No {DEPLOYMENT_NAME} under {artifacts}. "
            "Build first: fprime-util generate && fprime-util build"
        )
    if len(matches) > 1:
        native = [m for m in matches if m.parent.name in (os.uname().sysname,)]
        matches = native or matches
    return matches[0]


def ensure_wad(project_root: Path, deployment_dir: Path) -> None:
    """ Fetch the shareware WAD via fprime-get-doom when missing """
    wad = deployment_dir / "data" / "doom1.wad"
    if wad.is_file():
        return
    print(f"[INFO] {wad} missing; fetching shareware WAD with fprime-get-doom")
    result = subprocess.run(["fprime-get-doom"], cwd=project_root)
    if result.returncode != 0 or not wad.is_file():
        raise SystemExit("[ERROR] fprime-get-doom failed; provide a WAD manually and retry.")


def parse_args(argv):
    parser = argparse.ArgumentParser(
        prog="fprime-doom",
        description="Launch YAMCS + the DOOM web display + the fprime-stress-reference "
                    "flight software. Extra arguments are forwarded to fprime-yamcs.",
    )
    parser.add_argument("--project-root", type=Path, default=None,
                        help="fprime-stress-reference checkout root [default: auto-detected]")
    parser.add_argument("--no-app", action="store_true",
                        help="Do not launch the flight software binary (attach your own)")
    return parser.parse_known_args(argv)


def main(argv=None):
    args, passthrough = parse_args(sys.argv[1:] if argv is None else argv)
    project_root = (args.project_root or find_project_root(Path.cwd())).resolve()
    deployment_dir = find_deployment_dir(project_root)
    dictionary = deployment_dir / "dict" / "ReferenceDeploymentTopologyDictionary.json"
    app = deployment_dir / "bin" / DEPLOYMENT_NAME
    extension_dir = project_root / WEB_EXTENSION_RELATIVE
    for path, what in [(dictionary, "dictionary"), (extension_dir, "doom-display extension")]:
        if not path.exists():
            raise SystemExit(f"[ERROR] Missing {what}: {path}")

    command = ["fprime-yamcs", "--dictionary", str(dictionary),
               "--yamcs-web-extension-dirs", str(extension_dir),
               "--yamcs-realtime-only-channels", *REALTIME_ONLY_CHANNELS]
    if args.no_app:
        command.append("-n")
    else:
        if not app.is_file():
            raise SystemExit(f"[ERROR] Missing flight software binary: {app}")
        ensure_wad(project_root, deployment_dir)
        command += ["--app", str(app)]
    command += passthrough

    # The project fprime-gds.yml carries GDS-only options (gui-port, ...)
    # that fprime-yamcs does not understand; mask the auto-loaded config.
    with tempfile.NamedTemporaryFile("w", suffix=".yml", delete=False) as empty_config:
        empty_config.write("command-line-options: {}\n")
    if "-c" not in passthrough and "--config" not in passthrough:
        command += ["-c", empty_config.name]

    print(f"[INFO] fprime-doom: {' '.join(command)}")
    print("[INFO] YAMCS web UI: http://localhost:8090 - click the DOOM button, then Start.")
    # Run from the project root so the binary's relative WAD search works.
    return subprocess.run(command, cwd=project_root).returncode


if __name__ == "__main__":
    sys.exit(main())
