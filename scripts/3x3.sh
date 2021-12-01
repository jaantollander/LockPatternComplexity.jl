#!/bin/bash
minizinc src/nxn.mzn \
    -D "n=3;" \
    --solver gecode \
    --statistics \
    --all-solutions