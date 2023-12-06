using BasicProgrammingNCUES1121
using Documenter

DocMeta.setdocmeta!(BasicProgrammingNCUES1121, :DocTestSetup, :(using BasicProgrammingNCUES1121); recursive=true)

makedocs(;
    modules=[BasicProgrammingNCUES1121],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/BasicProgramming-NCUES-112-1/blob/{commit}{path}#{line}",
    sitename="基礎程式設計-NCUES-112-1",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/BasicProgramming-NCUES-112-1",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
        "課程須知" => "info.md",
        "課堂測驗成績" => "score_group.md"]
)

deploydocs(;
    repo="github.com/okatsn/BasicProgramming-NCUES-112-1",
    devbranch="main"
)
