function grid(n::Int)
    x = [i for i = 1:n for _ = 1:n]
    y = [j for _ = 1:n for j = 1:n]
    return x, y
end

function line_types(n::Int)
    xs = Int[0, 1, 1, 1]
    ys = Int[1, 0, 1, -1]
    ks = Int[n-1, n-1, n-1, n-1]
    for x1 = 1:n-2
        for y1 = (x1+1):n-1
            if gcd(x1, y1) == 1
                k = div(n - 1, y1)
                # 1
                push!(xs, x1)
                push!(ys, y1)
                push!(ks, k)
                # 2
                push!(xs, y1)
                push!(ys, x1)
                push!(ks, k)
                # 3
                push!(xs, x1)
                push!(ys, -y1)
                push!(ks, k)
                # 4
                push!(xs, y1)
                push!(ys, -x1)
                push!(ks, k)
            end
        end
    end
    return xs, ys, ks
end

function symmetries(n::Int)
    # Horizontal reflection
    reflect = [j + i * n for i = 0:n-1 for j = n:-1:1]
    # Rotate 90 degrees
    r90 = [j + i * n for j = 1:n for i = n-1:-1:0]
    r180 = r90[r90]
    r270 = r180[r90]
    r180_reflect = r180[reflect]
    r270_reflect = r270[reflect]
    return r90, r180, r270, reflect, r180_reflect, r270_reflect
end

"""Upper and lower bound for taxicab distance."""
function bounds(n::Int)
    M = n^2 - 1
    ys, xs, ks = line_types(n)
    # Taxicab distance of each line type
    x = abs.(ys) + abs.(xs)
    # Taxicab distance of shortest unique line types
    d_lb = sum(sort(x)[1:M])
    # Taxicab distance of longest unique line types
    d_ub = sum(reverse(sort(x .* ks))[1:M])
    return d_lb, d_ub
end

function data(n::Int)
    m = n^2
    M = m - 1
    x, y = grid(n)
    xs, ys, ks = line_types(n)
    N = length(ks)
    r90, r180, r270, reflect, r180_reflect, r270_reflect = symmetries(n)
    d_lb, d_ub = bounds(n)
    return ["n=$n;", "m=$m;", "x=$x;", "y=$y;", "M=$M;", "N=$N;",
        "xs=$(xs);", "ys=$(ys);", "ks=$(ks);",
        "r90=$r90;", "r180=$r180;", "r270=$r270;", "reflect=$reflect;",
        "r180_reflect=$r180_reflect;", "r270_reflect=$r270_reflect;", 
        "d_lb=$d_lb;", "d_ub=$d_ub;"]
end

function line_type(x1::Int, x2::Int, y1::Int, y2::Int)
    x = x2 - x1
    y = y2 - y1
    d = gcd(x, y)
    if x < 0
        return (div(-x, d), div(-y, d))
    else
        return (div(x, d), div(y, d))
    end
end

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
