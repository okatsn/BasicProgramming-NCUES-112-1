using BasicProgrammingNCUES1121, DataFrames#hide
using Statistics
using CSV
using Chain#hide
using PrettyTables#hide
using Markdown#hide
using Suppressor#hide
using Test

password = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
select!(password, :StudentID, :Name, :password)
function checkpassword(id::Int, inputcode)
    pd = Dict(password.StudentID .=> password.password)
    verified = pd[id] == inputcode
    if !verified
        @error("For ID $id, input password ($inputcode) is not the true ($(pd[id]))")
    end
    return verified
end

function verify(itmbscore)
    select(get_data(itmbscore), Cols("評分者姓名(我的名字)", "認證碼") => ByRow((id, pw) -> checkpassword(getstid(id), pw)) => :Verified) # simply test
    return itmbscore
end

function test(df)
    for row in eachrow(df)
        @test 80.0 <= row.Score_CCC <= 90.0
        @test 0.0 <= row.Score_YenYu <= 50.0
        @test 2.0 <= row.Score_InterMember <= 10.0
        @test 0.0 <= (row.Final_Score - row.Score_CCC - row.Score_YenYu) <= 40.0
    end
    return df
end

mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide
mlabscore |> prosheet! |> makewide!

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide
quizscore |> prosheet! |> makewide!

itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide
itmbscore |> verify |> prosheet! |> makewide!



pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
pscore |> prosheet! |> makewide!

finaltable0 = outerjoin(get_data.(
        [pscore, mlabscore, quizscore, itmbscore]
    )...;
    on=:StudentID)


finaltable = @chain finaltable0 begin
    transform(AsTable(Cols(r"Score\_")) => ByRow(nt -> sum(nt)) => :Final_Score)
    select(:StudentID, r"Test", r"Score")
end

test(finaltable)
