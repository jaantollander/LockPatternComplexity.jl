#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/6x6.dzn \
    --solver chuffed \
    --statistics \
    --all-solutions \
    --output-time \
    --two-pass