using EHTIM
using Documenter

makedocs(;
    modules=[EHTIM],
    authors="Kaj Wiik <kaj.wiik@utu.fi> and contributors",
    repo="https://github.com/KajWiik/EHTIM.jl/blob/{commit}{path}#L{line}",
    sitename="EHTIM.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://KajWiik.github.io/EHTIM.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/KajWiik/EHTIM.jl",
)
