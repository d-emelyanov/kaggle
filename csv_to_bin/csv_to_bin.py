import datatable as dt
import os
from argparse import ArgumentParser
from dataclasses import dataclass


def convert(f):
    new_file = '.'.join(f.split('.')[:-1] + ['jay'])
    dt.fread(f).to_jay(new_file)
    print(new_file)


def start():

    parser = ArgumentParser()
    parser.add_argument('--input', '-i', nargs='*')
    args = parser.parse_args()
    print(args.input)
    list(map(convert, args.input))
