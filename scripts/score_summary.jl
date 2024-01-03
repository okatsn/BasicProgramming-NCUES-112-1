using CairoMakie, AlgebraOfGraphics
using BasicProgrammingNCUES1121, DataFrames

# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; # for example

google_id = ARGS[1]

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/$google_id/edit?usp=sharing", QuizScore())
prosheet!(cloudscore)

plt = data(get_data(cloudscore)) * visual(Density) * mapping(:score) * mapping(layout=:Test_ID)
# density() failed for julia v1.10; This is not yet fixed by AlgebraOfGraphics. Refer https://discourse.julialang.org/t/julia-1-10-introduces-tuple-field-type-cannot-be-union-error-in-algebraofgraphics-jl/106389/5

f = draw(plt)

Makie.save(projectdir("docs", "src", "score_distribution.png"), f)
