using CSV, DataFrames, Markdown
using Random
using Chain
using BasicProgrammingNCUES1121
using SMTPClient
using Test

df = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
