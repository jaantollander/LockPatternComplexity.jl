#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/5x5.dzn \
    --solver chuffed \
    --statistics \
    --all-solutions \
    --output-time \
    --two-pass