using CairoMakie, AlgebraOfGraphics
using BasicProgrammingNCUES1121, DataFrames

# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; # for example

google_id = ARGS[1]

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/$google_id/edit?usp=sharing", QuizScore())
prosheet!(cloudscore)

plt = data(get_data(cloudscore)) * AlgebraOfGraphics.density() * mapping(:score) * mapping(layout=:Test_ID)

f = draw(plt)

Makie.save(projectdir("docs", "src", "score_distribution.png"), f)
