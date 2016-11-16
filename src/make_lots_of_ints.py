#!/usr/bin/env/python
import sys
from numpy.random import RandomState

random = RandomState(1)


def main(nlines, perline):
    random.seed(1)
    for line in range(nlines):
        print(*(+random.logistic(50, 3, perline).astype(int)))


if __name__ == '__main__':
    main(*(map(int, sys.argv[1:])))
