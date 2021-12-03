#!/bin/bash
minizinc models/nxn_sat.mzn models/instances/2x2.dzn \
    --solver gecode \
    --statistics \
    --all-solutions