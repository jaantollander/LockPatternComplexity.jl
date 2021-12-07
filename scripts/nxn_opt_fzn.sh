#!/bin/bash
n=$1
minizinc models/nxn_opt.mzn models/instances/${n}x${n}.dzn \
    --two-pass \
    --sac \
    --shave \
    --fzn models/fzn/${n}x${n}_opt.fzn \
    --compile \
    --no-output-ozn \
    --statistics > models/fzn/${n}x${n}_opt.txt