## --- Grid ---

# TODO: generalize for arbitrary grids

"""Two-dimensional grid."""
struct Grid
    x::Vector{Int}
    y::Vector{Int}
    n::Tuple{Int,Int}
end

Base.length(grid::Grid) = prod(grid.n)

function Grid(n::Int)
    x = [i for i = 1:n for _ = 1:n]
    y = [j for _ = 1:n for j = 1:n]
    Grid(x, y, (n, n))
end


## --- Line Types ---

struct LineTypes
    x::Vector{Int}
    y::Vector{Int}
    k::Vector{Int}
end

Base.length(t::LineTypes) = length(t.k)

"""Generate all `x` and `y` differences and their multiple `k` 
that represent each line type in a grid."""
function LineTypes(grid::Grid)
    (n, _) = grid.n
    xs = Int[0, 1, 1, 1]
    ys = Int[1, 0, 1, -1]
    ks = Int[n-1, n-1, n-1, n-1]
    for x = 1:n-2
        for y = (x+1):n-1
            if gcd(x, y) == 1
                k = div(n - 1, y)
                # 1
                push!(xs, x)
                push!(ys, y)
                push!(ks, k)
                # 2
                push!(xs, y)
                push!(ys, x)
                push!(ks, k)
                # 3
                push!(xs, x)
                push!(ys, -y)
                push!(ks, k)
                # 4
                push!(xs, y)
                push!(ys, -x)
                push!(ks, k)
            end
        end
    end
    return LineTypes(xs, ys, ks)
end

function line_type(x1::Int, x2::Int, y1::Int, y2::Int)
    x = x2 - x1
    y = y2 - y1
    d = gcd(x, y)
    if (x < 0) || (iszero(x) && y < 0)
        return (div(-x, d), div(-y, d))
    else
        return (div(x, d), div(y, d))
    end
end


## --- Symmetries ---

struct Symmetries
    p::Vector{Vector{Int}}
end

"""Generate all symmetrical permutations of lock pattern in a grid."""
function Symmetries(grid::Grid)
    (n, _) = grid.n
    # Horizontal reflection
    reflect = [j + i * n for i = 0:n-1 for j = n:-1:1]
    # Rotate 90 degrees
    r90 = [j + i * n for j = 1:n for i = n-1:-1:0]
    r180 = r90[r90]
    r270 = r180[r90]
    r180_reflect = r180[reflect]
    r270_reflect = r270[reflect]
    Symmetries([r90, r180, r270, reflect, r180_reflect, r270_reflect])
end


## --- Bounds ---

"""Upper and lower bound for taxicab distance."""
struct Bounds
    lb::Int
    ub::Int
end

function Bounds(grid::Grid)
    M = length(grid) - 1
    t = LineTypes(grid)
    # Taxicab distance of each line type
    x = abs.(t.y) + abs.(t.x)
    # Taxicab distance of shortest unique line types
    lb = sum(sort(x)[1:M])
    # Taxicab distance of longest unique line types
    ub = sum(reverse(sort(x .* t.k))[1:M])
    return Bounds(lb, ub)
end


# --- Generate model data ---

"""Generate the input data for the MiniZinc model."""
function data(grid::Grid)
    t = LineTypes(grid)
    s = Symmetries(grid)
    r90, r180, r270, reflect, r180_reflect, r270_reflect = s.p
    b = Bounds(grid)
    return [
        "m=$(length(grid));", "gx=$(grid.x);", "gy=$(grid.y);",
        "N=$(length(t));", "tx=$(t.x);", "ty=$(t.y);", "tk=$(t.k);",
        "r90=$r90;", "r180=$r180;", "r270=$r270;", "reflect=$reflect;",
        "r180_reflect=$r180_reflect;", "r270_reflect=$r270_reflect;",
        "d_lb=$(b.lb);", "d_ub=$(b.ub);"
    ]
end

function create_instance(n::Int, directory::AbstractString)
    grid = Grid(n)
    d = join(data(grid), "\n")
    write(joinpath(directory, "$(join(grid.n, "x")).dzn"), d)
end


## --- Extract solutions from output files ---

function parse_int_array(x::AbstractString; I = Int)
    [parse(I, t.match) for t in eachmatch(r"([0-9]+)", x)]
end

function extract_solutions(file::AbstractString)
    # Construct Regex pattern for extracting results from a text file
    int_array_pattern = raw"(?<pattern>\[[0-9]+(, [0-9]+)*\])"
    int_pattern = raw"(?<distance>[0-9]+)"
    result_pattern = Regex("pattern=$int_array_pattern" * "\n" * "distance=$int_pattern")

    txt = read(file, String)
    results = Dict{Int,Vector{Vector{Int}}}()
    for m in eachmatch(result_pattern, txt)
        lock_pattern = parse_int_array(m["pattern"])
        distance = parse(Int, m["distance"])
        if haskey(results, distance)
            push!(results[distance], lock_pattern)
        else
            results[distance] = [lock_pattern]
        end
    end
    return results
end
