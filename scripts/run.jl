using LockPatternComplexity
using ArgParse

function data(n::Int)
    N, xs, ys, ds = line_types(n)
    return "n=$n;N=$N;xs=$(xs);ys=$(ys);ds=$(ds);"
end

function command(n::Int, minizinc, solver, flags)::Cmd
    d = data(n)
    return `$minizinc src/nxn.mzn -D $d --solver $solver $flags`
end

s = ArgParseSettings()

@add_arg_table s begin
    "-n"
    help = "grid size"
    arg_type = Int
    default = 3
    "--minizinc"
    help = "full path to MiniZinc. Use command `which minizinc` to find it out."
    arg_type = String
    default = "/home/jaan/bin/MiniZincIDE-2.5.5-bundle-linux-x86_64/bin/minizinc"
end

args = parse_args(s)
n = args["n"]
minizinc = args["minizinc"]

function cmd(n)
    n == 2 && return command(2, minizinc, "gecode", ["--all-solutions", "--statistics"])
    n == 3 && return command(3, minizinc, "gecode", ["--all-solutions", "--statistics"])
    n == 4 && return command(4, minizinc, "chuffed", ["--all-solutions", "--statistics", "--two-pass"])
    n == 5 && return command(5, minizinc, "chuffed", ["--all-solutions", "--statistics", "--two-pass"])
    n == 6 && return command(6, minizinc, "chuffed", ["--all-solutions", "--statistics", "--two-pass"])
    error("")
end

run(cmd(n))
