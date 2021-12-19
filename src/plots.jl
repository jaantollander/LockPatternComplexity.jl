using Plots

"""Plot """
function canvas(; kwargs...)
    plot(; xticks = :none, yticks = :none, legend = false, axis = false, kwargs...)
end

"""Create unique color for all line types in the grid."""
function color_map(grid::Grid)
    t = LineTypes(grid)
    qs = collect(zip(t.x, t.y))
    g = cgrad(:inferno)
    zs = LinRange(0, 1, length(t))
    return Dict(d => RGB(g[z]) for (d, z) in zip(qs, zs))
end

function plot_grid!(plt, grid::Grid; kwargs...)
    scatter!(plt, grid.x, grid.y; kwargs...)
end

function plot_lines!(plt, lines::Vector{NTuple{2,Vector{Int}}}, colors::Vector{RGB}; kwargs...)
    for ((x, y), color) in zip(lines, colors)
        plot!(plt, x, y; linecolor=color, kwargs...)
    end
end

function plot_lock_pattern!(plt, grid::Grid, p::Vector{Int})
    c_map = color_map(grid)
    lines = NTuple{2,Vector{Int}}[]
    colors = RGB[]
    for i = 1:length(p)-1
        j = p[[i, i + 1]]
        x = grid.x[j]
        y = grid.y[j]
        t = line_type(x[1], x[2], y[1], y[2])
        push!(lines, (x, y))
        push!(colors, c_map[t])
    end
    plot_lines!(plt, lines, colors; linewidth = 3)
    plot_grid!(plt, grid; marker = :circle, color = :black, markersize = 5)
    return plt
end

function create_plots(n::Int, path::AbstractString, directory::AbstractString; limit::Int=0)
    grid = Grid(n)
    solutions = extract_solutions(path)
    for (distance, patterns) in solutions
        if distance ≥ limit
            root = mkpath(joinpath(directory, "$(join(grid.n, "x"))", "$(distance)"))
            for pattern in patterns
                plt = canvas(; size=(400, 400), backgroud=:lightgray)
                plot_lock_pattern!(plt, grid, pattern)
                savefig(plt, joinpath(root, "$(hash(pattern)).svg"))
            end
        end
    end
end
