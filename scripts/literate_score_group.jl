using BasicProgrammingNCUES1121, Literate

# Please use
# julia --project=@. -e 'include("scripts/literate_score_group.jl")' "<YOUR_InterMemberScore_Sheet_IDENTIFIEER>"
Literate.markdown(projectdir("scripts", "score_group.jl"), projectdir("docs/src"), documenter=true, flavor=Literate.DocumenterFlavor(), execute=true, preprocess=c -> replace(c, "YOUR_InterMemberScore_Sheet_IDENTIFIEER" => ARGS[1]))

# `documenter=true`: exports markdown that Documenter will process.
# `execute=true`: execute the .jl script in `Literate` stage; otherwise, codes will be executed at Documenter's stage.
# - `execute=true` along with `documenter=true` is crucial. In this way, a html table will be generated as the content of score_group.md in a code fence of `@raw html`.
# - If `execute=false` along with `documenter=true`, the Documenter stage will fail since secrets is required in this script (you cannot explicitly put the sensitive information in code!).
# - If `execute=true` along with `documenter=false`, the html table will be put in a simple code fence and appears as raw strings. The result looks bad.
