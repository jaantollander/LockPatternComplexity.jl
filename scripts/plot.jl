include("../src/plots.jl")

for n in [3, 5]
    solutions = extract_solutions("results/$(n)x$(n).txt")
    for (distance, patterns) in solutions
        root = mkpath(joinpath("results", "$(n)x$(n)", "$(distance)"))
        for pattern in patterns
            plt = plot_nxn(n, pattern)
            savefig(plt, joinpath(root, "$(hash(pattern)).svg"))
        end
    end
end

for n in [2, 4, 6]
    solutions = extract_solutions("results/$(n)x$(n)_gen.txt")
    for (distance, patterns) in solutions
        root = mkpath(joinpath("results", "$(n)x$(n)", "$(distance)"))
        for pattern in patterns
            plt = plot_nxn(n, pattern)
            savefig(plt, joinpath(root, "$(hash(pattern)).svg"))
        end
    end
end
