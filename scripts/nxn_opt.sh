#!/bin/bash
n=$1
OUTFILE=$2

minizinc models/nxn_opt.mzn models/instances/${n}x${n}.dzn \
    --solver or-tools \
    --statistics \
    --all-solutions \
    --output-time \
    --two-pass \
    --sac \
    --shave \
    --pre-passes 0 \
    --parallel 4 \
    --free-search \
    --output-to-file $OUTFILE
