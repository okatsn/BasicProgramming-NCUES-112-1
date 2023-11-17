# Which exam will you take
using CSV, DataFrames, Markdown
using Random

df = CSV.read("data/BasicProgrammingStudentList_112-1.csv", DataFrame)

# Add password (only once)
# insertcols!(df, :password => [randstring(rand(5:8)) for _ in 1:nrow(df)])
# CSV.write("data/BasicProgrammingStudentList_112-1.csv", df)
