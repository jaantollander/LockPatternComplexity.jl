using Plots

function plot_nxn(n::Int, p::Vector{Int})
    x, y = grid(n)
    ds = [line_type(x[p[i]], x[p[i+1]], y[p[i]], y[p[i+1]]) for i = 1:length(p)-1]
    qs = sort(unique(ds))
    g = cgrad(:inferno)
    color_map = Dict(d => RGB(g[z]) for (d, z) in zip(qs, LinRange(0, 1, length(qs))))
    linecolors = [color_map[d] for d in ds]
    plt = plot(; xticks = :none, yticks = :none, legend = false, axis = false, size = (400, 400))
    plot!(plt, x[p], y[p]; linecolor = linecolors, linewidth = 3)
    scatter!(plt, x, y; marker = :circle, color = :black, markersize = 5)
    return plt
end
