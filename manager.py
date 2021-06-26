#!/usr/bin/env python3

import argparse
import os
from pathlib import Path
import subprocess

import requests

# TODO
# Nothing todo ATM.

PRELIM_TEST = False


def error_print(msg):
    print(f"!ERROR! => {msg}")


def info_print(msg):
    print(f"=> {msg}")


def test_print(msg):
    print(f"==TEST== > {msg}")


def directory_exists(path):
    p = Path(path).expanduser().resolve()
    if not p.is_dir():
        error_print(f"cannot find directory '{str(p)}'.")
        return False
    else:
        return True


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

    # Test for config directories.
    config_dir = Path("~/.config/nvim").expanduser().resolve()
    if not config_dir.is_dir():
        info_print(f"could not find config directory '{str(config_dir)}'.")
        info_print("creating config directory.")
        config_dir.mkdir(parents=True)

    dest = Path("~/.config/nvim/init.vim").expanduser().resolve()
    if dest.is_file():
        info_print("neovim's init.vim already exists. skipping.")
    elif PRELIM_TEST:
        test_print("init.vim file does not exist. skipping install due to test status.")
    else:
        dest.symlink_to(Path("./nvim/init.vim").absolute())
        try:
            subprocess.run("nvim +PlugInstall +qall --headless".split(), check=True)
        except FileNotFoundError:
            error_print("nvim isn't installed? and you're trying to configure it??")
        except subprocess.CalledProcessError:
            error_print("nvim didn't like installing the plugins. check your config.")
            error_print(
                (
                    "most likely you simply need to:"
                    "  1. start neovim, ignoring errors."
                    "  2. run :PlugInstall ."
                    "  3. enjoy!"
                )
            )


if __name__ == "__main__":
    task_index = {
        #  "vim-plug": vim_plug,
        "neovim": neovim,
    }

    parser = argparse.ArgumentParser(
        description="Manager of custom configs. Use one of the choices below."
    )
    parser.add_argument("tasks", nargs="*", choices=list(task_index))

    args = parser.parse_args()
    for task in args.tasks:
        task_index[task]()
