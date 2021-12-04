#!/bin/bash
minizinc models/nxn_opt.mzn models/instances/5x5.dzn \
    --two-pass \
    --fzn models/fzn/5x5_opt.fzn \
    --compile \
    --no-output-ozn \
    --statistics > models/fzn/5x5_opt.txt