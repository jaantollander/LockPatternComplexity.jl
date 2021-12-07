#!/bin/bash
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --output=results/nxn_opt_%j.out
n=$1
OUTFILE=$2

srun minizinc models/nxn_opt.mzn models/instances/${n}x${n}.dzn \
    --solver or-tools \
    --statistics \
    --all-solutions \
    --output-time \
    --two-pass \
    --sac \
    --shave \
    --pre-passes 0 \
    --parallel 1 \
    --free-search \
    --output-to-file $OUTFILE
