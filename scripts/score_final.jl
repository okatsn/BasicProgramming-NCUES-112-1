using BasicProgrammingNCUES1121, DataFrames#hide
using Statistics
using CSV
using Chain#hide
using PrettyTables#hide
using Markdown#hide
using Suppressor#hide

password = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
select!(password, :StudentID, :Name, :password)

mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide

prosheet!(quizscore)
dfq = makewide!(quizscore)



itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide

getstid(str) = split(str, "-") |> last |> str -> parse(Int, str)
function checkpassword(id::Int, inputcode)
    pd = Dict(password.StudentID .=> password.password)
    verified = pd[id] == inputcode
    if !verified
        @error("For ID $id, input password ($inputcode) is not the true ($(pd[id]))")
    end
    return verified
end

df11 = @chain get_data(itmbscore) begin
    select("評分者姓名(我的名字)" => ByRow(getstid) => :Evaluator, "被評者姓名(組員姓名)" => ByRow(getstid) => :Evaluatee, :Score, "認證碼")
    select(Not("認證碼"), Cols(:Evaluator, "認證碼") => ByRow((id, pw) -> checkpassword(id, pw)) => :Verified)
end



pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
