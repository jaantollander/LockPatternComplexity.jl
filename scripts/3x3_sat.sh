#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/3x3.dzn \
    --solver gecode \
    --statistics \
    --all-solutions \
    --output-time