import sys
import os
import subprocess

from pathlib import Path
from psutil import process_iter


def reload_hyprpaper() -> None:
    proc_name = "hyprpaper"

    for proc in process_iter(["name"]):
        if proc.info["name"] == proc_name:
            proc.terminate()
            break
    subprocess.Popen(proc_name)


def hyprpaper_change_wallpapers(path: Path, monitor: str = "") -> None:
    config = Path("~/.config/hypr/hyprpaper.conf").expanduser()

    if not config.exists or not config.is_file():
        raise TypeError(f"Файл {config} не сущетвует.")
    elif not os.access(config, os.W_OK):
        raise PermissionError(f"Файл {config} не доступен для записи")

    with config.open("w") as f:
        f.write(f"""preload = {path.absolute()}
        wallpaper = {monitor}, {path.absolute()} 
        """)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        raise ValueError("Missing argument")
    path = Path(sys.argv[1])

    hyprpaper_change_wallpapers(path)
    reload_hyprpaper()
