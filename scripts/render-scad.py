#!/usr/bin/env python3

import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Any, Optional

SCAD_DIR = "scad"
PNG_DIR = "png"
STL_DIR = "stl"


def env_flag(name: str) -> bool:
    return os.environ.get(name, "false").lower() == "true"


def git_tracked(path: Path) -> bool:
    return (
        subprocess.run(
            ["git", "ls-files", "--error-unmatch", str(path)],
            capture_output=True,
        ).returncode
        == 0
    )


def git_unchanged(path: Path) -> bool:
    return (
        subprocess.run(
            ["git", "diff", "--quiet", "HEAD", "--", str(path)],
            capture_output=True,
        ).returncode
        == 0
    )


def load_viewports(path: Path) -> dict[str, Any]:
    if not path.is_file():
        return {}
    with path.open(encoding="utf-8") as f:
        return json.load(f)


def camera_string(entry: Any) -> Optional[str]:
    if entry is None:
        return None
    if isinstance(entry, str):
        return entry
    if isinstance(entry, dict):
        translate = entry["translate"]
        rotate = entry["rotate"]
        distance = entry["distance"]
        return ",".join(str(x) for x in [*translate, *rotate, distance])
    return None


def should_skip(
    scad: Path, png: Path, stl: Path, skip_png: bool, skip_stl: bool
) -> bool:
    if not git_tracked(scad) or not git_unchanged(scad):
        return False
    if not skip_png and not png.is_file():
        return False
    if not skip_stl and not stl.is_file():
        return False
    return True


def run(cmd: list[str]) -> None:
    subprocess.run(cmd, check=True)


def render_png(scad: Path, png: Path, size: int, camera: Optional[str]) -> None:
    print(f"Generating image for {scad}")
    png.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp:
        tmp_path = Path(tmp.name)
    try:
        cmd = ["openscad", "--imgsize=4000,4000"]
        if camera:
            cmd.append(f"--camera={camera}")
        cmd.extend(["-o", str(tmp_path), str(scad)])
        run(cmd)
        run(["convert", str(tmp_path), "-resize", f"{size}x{size}", str(png)])
        print("done.")
    finally:
        tmp_path.unlink(missing_ok=True)


def render_stl(scad: Path, stl: Path) -> None:
    print(f"Generating STL for {scad}")
    stl.parent.mkdir(parents=True, exist_ok=True)
    run(["openscad", "-o", str(stl), str(scad)])
    print("done.")


def main() -> int:
    parser = argparse.ArgumentParser(description="Render OpenSCAD files to PNG and STL")
    parser.add_argument(
        "dir",
        type=Path,
        help=f"directory containing {SCAD_DIR}/, {PNG_DIR}/, and {STL_DIR}/ subdirectories",
    )
    parser.add_argument("size", type=int, help="PNG output size in pixels")
    args = parser.parse_args()

    skip_png = env_flag("SKIP_PNG")
    skip_stl = env_flag("SKIP_STL")
    no_skip = env_flag("NO_SKIP")
    viewports_file = Path(
        os.environ.get("VIEWPORTS_FILE", "examples/viewports.json")
    )
    viewports = load_viewports(viewports_file)

    scad_dir = args.dir / SCAD_DIR
    png_dir = args.dir / PNG_DIR
    stl_dir = args.dir / STL_DIR

    for scad in sorted(scad_dir.glob("*.scad")):
        name = scad.stem
        png = png_dir / f"{name}.png"
        stl = stl_dir / f"{name}.stl"

        if not no_skip and should_skip(scad, png, stl, skip_png, skip_stl):
            print(f"Skipping {scad} (unchanged)")
            continue

        camera = camera_string(viewports.get(name))

        if not skip_png:
            render_png(scad, png, args.size, camera)
        if not skip_stl:
            render_stl(scad, stl)

    return 0


if __name__ == "__main__":
    sys.exit(main())
