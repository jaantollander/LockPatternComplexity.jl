#!/bin/bash
minizinc src/nxn.mzn \
    -D "n=5;" \
    --solver chuffed \
    --statistics \
    --all-solutions \
    --two-pass