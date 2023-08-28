#!/usr/bin/env python3

import argparse
# import glob
import logging
# import multiprocessing as mp
# import numpy as np
# import openpyxl
import os
# import pandas as pd
# import re
import sys
# import tempfile
# import xlsxwriter

# from alive_progress import alive_bar, config_handler
# from datetime import datetime
# ==============================================================================
# Config
# logging
date_fmt = '%Y-%m-%d %H:%M:%S'
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    datefmt=date_fmt)
logger = logging.getLogger(name='%(prog)s')
# alive-progress
# bar_title_length = 52
# config_handler.set_global(length=40, bar='classic2')
# SINGLE_LEFT_BOTTOM = u'\u2514\u2500'
# ==============================================================================


def changeParserActioGroupsOrder(parser):
    s_required = parser._action_groups.pop()
    s_optional = parser._action_groups.pop()
    parser._action_groups.append(s_required)
    parser._action_groups.append(s_optional)

    return parser


def setup_argument_parser():
    class CustomHelpFormatter(
            argparse.ArgumentDefaultsHelpFormatter,
            argparse.RawTextHelpFormatter,
            argparse.RawDescriptionHelpFormatter):
        pass

    parser = argparse.ArgumentParser(
        description='This script ...',
        formatter_class=CustomHelpFormatter)

    program = '%(prog)s'
    ver = '0.2'
    last_update = '2021-10-14'
    version_str = f'{program}\n  version:\t{ver}\n  last update:\t{last_update}'
    parser.add_argument('--version', action='version', version=version_str)

    optional = parser._action_groups.pop()
    required = parser.add_argument_group('required arguments')

    # Required args
    required.add_argument('-i', '--input_dir', required=True,
                          help='Input directory with fastq samples to process.')
    # Optional args
    optional.add_argument('-p', '--prefix', required=False,
                          default='string_results',
                          help='Prefix for output files')
    optional.add_argument('-j', '--jobs', required=False, type=int,
                          default=8,
                          help='Number of parallel jobs or STing instances to run.')
    optional.add_argument('-g', '--gzipped', required=0,
                          action='store_true',
                          default=False,
                          help='Set if samples to process are gzipped (.fastq.gz)')

    parser._action_groups.append(optional)
    return parser


def filesExist(file_list):
    ok = True
    for f in file_list:
        if not os.path.exists(f):
            ok = False
            logger.error(f'The file "{f}" does not exist.')
    return ok


def main():
    parser = setup_argument_parser()

    if len(sys.argv) == 1:
        logger.error(f'One or more required arguments are missing\n')
        parser.print_help(sys.stderr)
        sys.exit(1)

    args = parser.parse_args()

    files_to_check = [args.input_file]

    if not filesExist(files_to_check):
        sys.exit(1)


if __name__ == '__main__':
    main()
