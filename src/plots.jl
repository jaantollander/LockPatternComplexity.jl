using Plots

function plot_nxn(n::Int, p::Vector{Int})
    x, y = grid(n)

    # Create unique color for each possible line type in the grid.
    xs, ys, _ = line_types(n)
    qs = collect(zip(xs, ys))
    g = cgrad(:inferno)
    color_map = Dict(d => RGB(g[z]) for (d, z) in zip(qs, LinRange(0, 1, length(qs))))

    # Create the plot
    plt = plot(; xticks = :none, yticks = :none, legend = false, axis = false, size = (400, 400), background=:lightgray)

    # Plot the lines
    for i = 1:length(p)-1
        j = p[[i, i + 1]]
        x′ = x[j]
        y′ = y[j]
        t = line_type(x′[1], x′[2], y′[1], y′[2])
        plot!(plt, x′, y′; linecolor = color_map[t], linewidth = 3)
    end

    # Plot the grid
    scatter!(plt, x, y; marker = :circle, color = :black, markersize = 5)

    return plt
end

function create_plots(n::Int, path::AbstractString, directory::AbstractString; limit::Int=0)
    solutions = extract_solutions(path)
    for (distance, patterns) in solutions
        if distance ≥ limit
            root = mkpath(joinpath(directory, "$(n)x$(n)", "$(distance)"))
            for pattern in patterns
                plt = plot_nxn(n, pattern)
                savefig(plt, joinpath(root, "$(hash(pattern)).svg"))
            end
        end
    end
end
