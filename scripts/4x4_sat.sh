#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/4x4.dzn \
    --solver chuffed \
    --statistics \
    --all-solutions \
    --two-pass