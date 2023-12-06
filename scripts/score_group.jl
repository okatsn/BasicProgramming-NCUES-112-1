using CairoMakie, AlgebraOfGraphics
using BasicProgrammingNCUES1121, DataFrames
using Chain

# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; # for example

google_id = ARGS[1]

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/$google_id/edit?usp=sharing", GroupScore())
# In your local machine:
# cloudscore = readgsheet(GroupScore())

# prosheet!(cloudscore) # CHECKPOINT: No method supports yet
score = cloudscore.data
score1 = select(score,
    "電子郵件地址" => :Email,
    "認證碼" => :passkey,
    "評分者姓名(我的名字)" => :Evaluator,
    "被評者姓名(組員姓名)" => :Evaluatee
)

@chain score1 begin
    groupby(:Evaluator)
    combine(nrow => "已評組員數")
    display
end



@chain score1 begin
    groupby(:Evaluatee)
    combine(nrow => "被評次數")
    display
end








# Makie.save(projectdir("docs", "src", "score_distribution.png"), f)
