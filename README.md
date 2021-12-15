# Solving the Most Complex Lock Patterns
3×3 | 4×4
:-:|:-:
![](plots/3x3/22/8827232152991697021.svg) | ![](plots/4x4/61/3959962646779093142.svg)
distance: 22* | distance: 61*

5×5 | 6×6
:-:|:-:
![](plots/5x5/119/17529919773630584012.svg) | ![](plots/6x6/207/2064057785432189769.svg)
distance: 119 | distance: 207

7×7 | 7×7
:-: | :-:
![](plots/7x7/315/16843976087494029817.svg) | ![](plots/7x7/317/4374660966625510281.svg)
distance=315 | distance=317

<!-- [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jaantollander.github.io/LockPatternComplexity.jl/stable) -->
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jaantollander.github.io/LockPatternComplexity.jl/dev)
[![Build Status](https://github.com/jaantollander/LockPatternComplexity.jl/workflows/CI/badge.svg)](https://github.com/jaantollander/LockPatternComplexity.jl/actions)
[![DOI](https://zenodo.org/badge/433790288.svg)](https://zenodo.org/badge/latestdoi/433790288)

## About
In this repository, we present solutions for the most complex lock patterns using the [MiniZinc](https://www.minizinc.org/) modeling language and the powerful [Google OR-Tools](https://developers.google.com/optimization/) solver. Additionally, we use the [Julia Language](https://julialang.org/) to generate the input data and analyze the results.

This repository was inspired by the video [*What Is The Most Complicated Lock Pattern?*](https://www.youtube.com/watch?v=PKjbBQ0PBCQ) by *Dr. Zye*. I highly recommend watching it! Also, you can try out lock patterns with [lock pattern demo](https://tympanix.github.io/pattern-lock-js/) by @tympanix.

We use a generalized definition of maximum complexity for a lock pattern, presented in *Dr. Zye*'s video, such that it has solutions for all n×n grids while preserving the original solutions. Our definition requires all lines in the pattern to have a unique "type" (slope), and we maximize the total ["taxicab" distance](https://en.wikipedia.org/wiki/Taxicab_geometry) of the pattern, which results in greater visual complexity for the patterns. The problem is a **combinatorial optimization** problem. The  [**documentation**](https://jaantollander.github.io/LockPatternComplexity.jl/dev/) covers the theoretical aspect of the problem.


## Structure
This repository is structured as follows:

* The [`src/`](./src/) directory contains Julia code.
* The [`models/`](./models/) directory contains the MiniZinc models.
* The [`scripts/`](./scripts/) directory contains scripts for generating data files, running the model, and plotting the results.
* The [`results/`](./results/) directory contains the text output from the models.
* The [`plots/`](./plots/) directory contains the generated SVG plots for each grid size and taxicab distance in format `<grid>/<distance>/<id>.svg`. The `<id>` is a unique identified generated using hash of the pattern.


## Instructions
To begin, we need to install MiniZinc and Google OR-Tools. On Linux, we can use the following [shell scripts](https://github.com/jaantollander/install-minizinc-ortools) for the installation.

Then, we can run shell scripts from the `scripts` directory and write the output to the `results/3x3.txt` file. For example, we can run the optimization model using the following command.

```bash
./scripts/nxn_opt.sh 3 results/3x3.txt
```


## Open Questions
~~Can we find a max complexity pattern for a 4×4 grid that provably maximizes the taxicab distance?~~

Can we find a max complexity pattern for a 5×5 grid that provably maximizes the taxicab distance?

~~Can we find a max complexity pattern for a 7×7 grid?~~
