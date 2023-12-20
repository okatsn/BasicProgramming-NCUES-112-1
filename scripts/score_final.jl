using BasicProgrammingNCUES1121, DataFrames#hide
using Statistics
using CSV
using Chain#hide
using PrettyTables#hide
using Markdown#hide
using Suppressor#hide

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

mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide
mlabscore |> prosheet! |> makewide!

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide
quizscore |> prosheet! |> makewide!

itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide
itmbscore |> verify |> prosheet! |> makewide!



pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
pscore |> prosheet! |> makewide!

finaltable = outerjoin(get_data.(
        [pscore, mlabscore, quizscore, itmbscore]
    )...;
    on=:StudentID)


@chain finaltable begin
    transform(AsTable(Cols(r"Score_Test\d")) => ByRow(nt -> mean(nt) * 0.4) => :CCC_Quiz)
    transform(AsTable([:Score_CCC, :Score_InterMember]) => ByRow(sum) => :CCC_Proj)
    transform(:Score_YenYu => :YenYu_all)
    transform(AsTable(Cols(r"CCC_", r"YenYu")) => ByRow(sum) => :Final_Score)
    select(:StudentID, r"Score")
end
