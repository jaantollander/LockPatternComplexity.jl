using LockPatternComplexity
using Documenter

DocMeta.setdocmeta!(LockPatternComplexity, :DocTestSetup, :(using LockPatternComplexity); recursive=true)

makedocs(;
    modules=[LockPatternComplexity],
    authors="Jaan Tollander de Balsch",
    repo="https://github.com/jaantollander/LockPatternComplexity.jl/blob/{commit}{path}#{line}",
    sitename="LockPatternComplexity.jl",
    format=Documenter.HTML(;
        prettyurls=true,
        canonical="https://jaantollander.github.io/LockPatternComplexity.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/jaantollander/LockPatternComplexity.jl",
)
