module LockPatternComplexity

include("functions.jl")
export Grid, LineTypes, Symmetries, Bounds, line_type
export data, extract_solutions, create_instance

include("plots.jl")
export canvas, color_map, plot_grid!, plot_lines!, plot_lock_pattern!, create_plots

end
