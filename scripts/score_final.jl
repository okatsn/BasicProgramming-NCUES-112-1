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
    return nothing
end

mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide

prosheet!(quizscore)
dfq = makewide!(quizscore)



itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide

verify(itmbscore)

prosheet!(itmbscore)


pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
