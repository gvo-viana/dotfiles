#!/usr/bin/env python3
import os


def con_str(file: str) -> str:
    ret_str = (
        f"inkscape {file} "
        "--export-area-drawing "
        "--export-text-to-path "
        f"--export-filename={file[:-3]}pdf"
    )
    return ret_str


files = [os.system(con_str(f)) for f in os.listdir("./") if f.endswith("svg")]
print("Done!")
