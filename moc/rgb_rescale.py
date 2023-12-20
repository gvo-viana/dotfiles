#! /usr/bin/env python3

import os
from typing import List


def get_input() -> List[int]:
    """Fetch the values given by the user to further convert them into a list
    of valid integers."""
    try:
        prompt = '\nEnter the RGB values [e.g.: 10 153 230 or #0a99e6]\n  >>> '
        data = input(prompt).strip()

        if data.startswith('#'):
            data = data.strip('#')

            return [int(i, base=16) for i in (data[0:2], data[2:4], data[4:])]

        return [int(i) for i in data.split()]

    except ValueError:
        print(f'"[{data}]" is incorrect. You must give integers only!')

        return get_input()


def rescale_to_base1000(*args) -> List[int]:
    """Rescale a list of given numbers to further convert them into a list of
    valid integers."""
    scale_factor = 1000 / 255

    return [round(i * scale_factor) for i in args]


def repeat():
    """Answer the user about to continue or to stop the program."""
    ans = input('\nConvert a new value [y/n]: ').strip().lower()

    if ans in frozenset('y yes ok s sim'.split()):
        return True

    return False


def main():
    """Run the program actions."""

    while True:
        rgb_lst = rescale_to_base1000(*get_input())
        print(f'RGB_1000 = {rgb_lst}')

        if not repeat():
            break


if __name__ == '__main__':
    os.system('clear')
    main()
