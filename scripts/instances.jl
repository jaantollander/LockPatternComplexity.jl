using LockPatternComplexity

function instance(n::Int; directory=joinpath("models", "instances"))
    d = join(data(n), "\n")
    write(joinpath(directory, "$(n)x$(n).dzn"), d)
end

instance(2)
instance(3)
instance(4)
instance(5)
instance(6)
instance(7)
