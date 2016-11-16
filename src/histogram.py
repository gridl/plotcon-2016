#!/usr/bin/env/python
import sys
import warnings; warnings.simplefilter('ignore')  # seaborn import warnings.
import matplotlib as mpl
import seaborn as sns


def draw_histogram(inpath, outpath):
    with open(inpath) as f:
        ints = [int(s) for line in f for s in line.split()]
    axes = sns.distplot(ints, bins=range(0, 100))
    axes.figure.savefig(outpath, dpi=500)


if __name__ == '__main__':
    draw_histogram(*sys.argv[1:])
