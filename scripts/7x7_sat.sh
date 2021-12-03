#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/7x7.dzn \
    --solver chuffed \
    --statistics \
    --all-solutions \
    --two-pass