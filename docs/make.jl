using BasicProgrammingNCUES1121
using Documenter

DocMeta.setdocmeta!(BasicProgrammingNCUES1121, :DocTestSetup, :(using BasicProgrammingNCUES1121); recursive=true)

makedocs(;
    modules=[BasicProgrammingNCUES1121],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/BasicProgrammingNCUES1121.jl/blob/{commit}{path}#{line}",
    sitename="BasicProgrammingNCUES1121.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/BasicProgrammingNCUES1121.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/BasicProgrammingNCUES1121.jl",
    devbranch="main",
)
