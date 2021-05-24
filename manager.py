#!/usr/bin/env python3

import argparse
import os
from pathlib import Path
import shutil
import subprocess

import requests

PRELIM_TEST = True


def error_print(msg):
    print(f"!ERROR! => {msg}")


def info_print(msg):
    print(f"=> {msg}")


def test_print(msg):
    print(f"==TEST== > {msg}")


def vim_plug():
    indep = Path("nvim") / "site" / "autoload" / "plug.vim"
    xdg_data_home = os.getenv("XDG_DATA_HOME")
    if xdg_data_home:
        dest = Path(xdg_data_home) / indep
    else:
        dest = Path.home() / ".local" / "share" / indep

    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    if dest.is_file():
        info_print("vim-plug is already installed. skipping.")
    elif PRELIM_TEST:
        test_print("vim-plug file does not exist. skipping install due to test status.")
    else:
        vim_plug_file = requests.get(url)
        with open(dest, "w") as f:
            f.write(vim_plug_file)


def neovim():
    vim_plug()
    dest = Path("~/.config/nvim/init.vim").expanduser()
    if dest.is_file():
        info_print("neovim's init.vim already exists. skipping.")
    elif PRELIM_TEST:
        test_print("init.vim file does not exist. skipping install due to test status.")
    else:
        shutil.copy(Path("./nvim/init.vim"), dest)
        try:
            subprocess.run("nvim +PlugInstall +qall --headless".split(), check=True)
        except FileNotFoundError:
            error_print("nvim isn't installed? and you're trying to configure it??")
        except subprocess.CalledProcessError:
            error_print("nvim didn't like installing the plugins. check your config.")


if __name__ == "__main__":
    task_index = {
        "vim-plug": vim_plug,
        "neovim": neovim,
    }

    parser = argparse.ArgumentParser(
        description="Manager of custom configs. Use one of the choices below."
    )
    parser.add_argument("tasks", nargs="*", choices=list(task_index))

    args = parser.parse_args()
    for task in args.tasks:
        task_index[task]()
