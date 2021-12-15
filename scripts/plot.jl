using LockPatternComplexity

directory = "plots"
create_plots(2, "results/2x2_sat.txt", directory; limit=5)
create_plots(3, "results/3x3_sat.txt", directory; limit=22)
create_plots(4, "results/4x4_opt.txt", directory; limit=61)
create_plots(4, "results/4x4_opt2.txt", directory; limit=61)
create_plots(5, "results/5x5_opt.txt", directory; limit=119)
create_plots(6, "results/6x6_opt.txt", directory; limit=207)
create_plots(7, "results/7x7_opt.txt", directory; limit=313)
