function grid(n::Int)
    x = [i for i = 1:n for _ = 1:n]
    y = [j for _ = 1:n for j = 1:n]
    return x, y
end

function line_types(n::Int)
    xs = Int[0, 1, 1, 1]
    ys = Int[1, 0, 1, -1]
    ds = Int[n-1, n-1, n-1, n-1]
    for x1 = 1:n-2
        for y1 = (x1+1):n-1
            if gcd(x1, y1) == 1
                d = div(n - 1, y1)
                # 1
                push!(xs, x1)
                push!(ys, y1)
                push!(ds, d)
                # 2
                push!(xs, y1)
                push!(ys, x1)
                push!(ds, d)
                # 3
                push!(xs, x1)
                push!(ys, -y1)
                push!(ds, d)
                # 4
                push!(xs, y1)
                push!(ys, -x1)
                push!(ds, d)
            end
        end
    end
    N = length(ds)
    return N, xs, ys, ds
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

function parse_int_array(x::AbstractString; I=Int)
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

# TODO: lock pattern symmetries
