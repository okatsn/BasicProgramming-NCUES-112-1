# ---
# title: 成績一覽
# author: STUDIDNUM STUDNAME (STUDDEPT)
# ---


# ```julia; echo = false
# using BasicProgrammingNCUES1121, DataFrames, CSV
# # Generate personal report for every student according to cloud score.
# # Hint: you can move these code to calc_score.jl for debug purposes.
# cloudscore = readgsheet(QuizScore())
# prosheet!(cloudscore)
# makewide!(cloudscore)
# localtable = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
# df = outerjoin(localtable, get_data(cloudscore); on=[:StudentID])
# # Student ID nmuber is: STUDIDNUM
# filter!(:StudentID => (x -> x == STUDIDNUM), df)
# @assert length(unique(df.Test_ID)) == nrow(df)
# @assert nrow(df) <= 4
# select!(df, :Test_ID => ByRow(x -> match(r"(?<=Test)\d+", x).match) => "測驗編號", :Test_ID => ByRow(x -> match(r"[A-Za-z]+\d+\z", x).match) => "測驗日期", Cols(r"Quiz"))
# ```
