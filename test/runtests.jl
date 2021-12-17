using LockPatternComplexity
using Test

@testset "LockPatternComplexity.jl" begin
    # Tests should execute without errors.
    grid = Grid(3)
    line_types = LineTypes(grid)
    symmetries = Symmetries(grid)
    bounds = Bounds(grid)
    data(grid)
    tmp = mktempdir()
    create_instance(3, tmp)
    extract_solutions(joinpath(@__DIR__, "output"))

    @test true
end
