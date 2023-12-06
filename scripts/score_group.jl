using CairoMakie, AlgebraOfGraphics
using BasicProgrammingNCUES1121, DataFrames

# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; # for example

google_id = ARGS[1]

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/$google_id/edit?usp=sharing", GroupScore())
# In your local machine: cloudscore = readgsheet(GroupScore())
# prosheet!(cloudscore) # CHECKPOINT: No method supports yet
# Makie.save(projectdir("docs", "src", "score_distribution.png"), f)
