include("../src/functions.jl")

n = 4  # 2, 4, 6
N, xs, ys, ds = line_types(n)
minizinc = "/home/jaan/bin/MiniZincIDE-2.5.5-bundle-linux-x86_64/bin/minizinc"
cmd = `$minizinc src/nxn_gen.mzn 
       -D "n=$n;N=$N;xs=$(string(xs));ys=$(string(ys));ds=$(string(ds));"
       --solver chuffed
       --statistics 
       --two-pass`
       # --all-solutions

run(cmd)
