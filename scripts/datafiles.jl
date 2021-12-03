using LockPatternComplexity

function datafile(n::Int; directory=joinpath("models", "instances"))
    d = join(data(n), "\n")
    write(joinpath(directory, "$(n)x$(n).dzn"), d)
end

datafile(2)
datafile(3)
datafile(4)
datafile(5)
datafile(6)
datafile(7)
