using BasicProgrammingNCUES1121, Literate

# Please use
# julia --project=@. -e 'include("scripts/literate_score_group.jl")' "<YOUR_GroupScore_Sheet_IDENTIFIEER>"
Literate.markdown(projectdir("scripts", "score_group.jl"), projectdir("docs/src"), documenter=false, flavor=Literate.DocumenterFlavor(), execute=true, preprocess=c -> replace(c, "YOUR_GroupScore_Sheet_IDENTIFIEER" => ARGS[1]))
