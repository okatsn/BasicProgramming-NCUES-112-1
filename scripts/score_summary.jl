using CairoMakie, AlgebraOfGraphics
using BasicProgrammingNCUES1121, DataFrames

# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; # for example

google_id = ARGS[1]

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/$google_id/edit?usp=sharing", QuizScore())
prosheet!(cloudscore)

plt = data(get_data(cloudscore)) * AlgebraOfGraphics.density() * mapping(:score) * mapping(layout=:Test_ID)

f = draw(plt)

Makie.save(projectdir("docs", "src", "score_distribution.png"), f)

# # Send Email
email = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
select!(email, :StudentID, :Name, :Email)


quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide

tables = @chain quizscore begin
    deepcopy
    prosheet!
    get_data
    unstack([:StudentID, :Test_ID], :Quiz_ID, :score)
    groupby(:Test_ID)
    collect
    outerjoin(_...; on=:StudentID, makeunique=true)
    outerjoin(email; on=:StudentID)
end
