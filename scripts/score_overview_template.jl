# ---
# title: 成績一覽
# author: STUDIDNUM STUDNAME (STUDDEPT)
# ---


# ```julia; echo = false
# using BasicProgrammingNCUES1121, DataFrames, CSV
# df = CSV.read(dir_temp("temp.csv"), DataFrame)
# filter!(:StudentID => (x -> x == STUDIDNUM), df)
# @assert length(unique(df.Test_ID)) == nrow(df)
# @assert nrow(df) <= 4
# select!(df, :Test_ID => ByRow(x -> match(r"(?<=Test)\d+", x).match) => "測驗編號", :Test_ID => ByRow(x -> match(r"[A-Za-z]+\d+\z", x).match) => "測驗日期", Cols(r"Quiz") )
# ```
