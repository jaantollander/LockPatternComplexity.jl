using LockPatternComplexity
using Plots: savefig

function create_plots(n::Int, path::AbstractString; limit::Int=0)
    solutions = extract_solutions(path)
    for (distance, patterns) in solutions
        distance ≤ limit && continue
        root = mkpath(joinpath("plots", "$(n)x$(n)", "$(distance)"))
        for pattern in patterns
            plt = plot_nxn(n, pattern)
            savefig(plt, joinpath(root, "$(hash(pattern)).svg"))
        end
    end
end

create_plots(2, "results/2x2_sat.txt"; limit=0)
create_plots(3, "results/3x3_sat.txt"; limit=20)
create_plots(4, "results/4x4_opt.txt"; limit=56)
create_plots(5, "results/5x5_sat.txt"; limit=113)
create_plots(5, "results/5x5_opt.txt"; limit=113)
create_plots(5, "results/5x5_opt2.txt"; limit=113)
create_plots(6, "results/6x6_sat.txt"; limit=193)
create_plots(7, "results/7x7_sat.txt"; limit=0)
