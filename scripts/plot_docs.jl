using LockPatternComplexity
using Plots
using Random

function plot_line_types(grid)
    (n, _) = grid.n
    cmap = color_map(grid)
    t = LineTypes(grid)
    lines = (NTuple{2,Vector{Int}}[], NTuple{2,Vector{Int}}[])
    colors = (RGB[], RGB[])
    lines2 = (NTuple{2,Vector{Int}}[], NTuple{2,Vector{Int}}[])
    colors2 = (RGB[], RGB[])
    for (x, y, k) in zip(t.x, t.y, t.k)
        if y ≥ 0
            push!(lines[1], ([1, 1 + x], [1, 1 + y]))
            push!(colors[1], cmap[(x, y)])
            if k > 1
                push!(lines2[1], ([1, 1 + k * x], [1, 1 + k * y]))
                push!(colors2[1], cmap[(x, y)])
            end
        else
            push!(lines[2], ([1, 1 + x], [n, n + y]))
            push!(colors[2], cmap[(x, y)])
            if k > 1
                push!(lines2[2], ([1, 1 + k * x], [n, n + k * y]))
                push!(colors2[2], cmap[(x, y)])
            end
        end
    end
    plt = (
        canvas(; size = (200, 200), backgroud = :lightgray),
        canvas(; size = (200, 200), backgroud = :lightgray)
    )
    plot_lines!(plt[1], lines[1], colors[1]; linewidth = 3)
    plot_lines!(plt[2], lines[2], colors[2]; linewidth = 3)
    plot_lines!(plt[1], lines2[1], colors2[1]; linewidth = 3, linestyle = :dash)
    plot_lines!(plt[2], lines2[2], colors2[2]; linewidth = 3, linestyle = :dash)
    plot_grid!(plt[1], grid; marker = :circle, color = :black, markersize = 5)
    plot_grid!(plt[2], grid; marker = :circle, color = :black, markersize = 5)
    return plt
end

grid = Grid(5)
pattern = (shuffle(1:length(grid)), shuffle(1:length(grid)))

begin
    plt = canvas(; size = (200, 200), backgroud = :lightgray)
    plot_grid!(plt, grid; marker = :circle, color = :black, markersize = 5)
    savefig(plt, "docs/src/plots/grid.svg")
end

begin
    plt = plot_line_types(grid)
    savefig(plt[1], "docs/src/plots/line_types_1.svg")
    savefig(plt[2], "docs/src/plots/line_types_2.svg")
end

for i = 1:2
    plt = canvas(size = (200, 200), backgroud = :lightgray)
    plot_lock_pattern!(plt, grid, pattern[i])
    savefig(plt, "docs/src/plots/lock_pattern_$i.svg")
end

# TODO: symmetries
