#!/bin/bash
minizinc models/nxn_opt.mzn models/instances/4x4.dzn \
    --two-pass \
    --fzn models/fzn/4x4_opt.fzn \
    --compile \
    --no-output-ozn \
    --statistics > models/fzn/4x4_opt.txt