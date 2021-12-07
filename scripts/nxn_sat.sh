#!/bin/bash
n=$1
minizinc models/nxn_sat.mzn models/instances/${n}x${n}.dzn \
    --solver chuffed \
    --all-solutions \
    --output-time \
    --two-pass