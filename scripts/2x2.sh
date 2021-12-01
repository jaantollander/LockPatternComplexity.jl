#!/bin/bash
minizinc src/nxn.mzn \
    -D "n=2;" \
    --solver gecode \
    --statistics