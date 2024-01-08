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
    verified = pd[id] == strip(inputcode)
    if !verified
        @error("For ID $id, input password ($inputcode) is not the true ($(pd[id]))")
    end
    return verified
end

function pswdverify(itmbscore)
    select(get_data(itmbscore), Cols("評分者姓名(我的名字)", "認證碼") => ByRow((id, pw) -> checkpassword(getstid(id), pw)) => :Verified) # simply test
    return itmbscore
end

function basictest(df)
    for row in eachrow(df)
        @test 80.0 <= row.Score_CCC <= 90.0
        @test 0.0 <= row.Score_YenYu <= 50.0
        @test 2.0 <= row.Score_InterMember <= 10.0
        @test 0.0 <= (row.Final_Score - row.Score_CCC - row.Score_YenYu) <= 40.0
        @test 0.0 <= row.Score_Quiz <= 40.0
        @test 0.0 <= row.Final_Score <= 100.0
        quizmean = getindex(row, r"Test") |> mean
        @test row.Score_Quiz == quizmean
    end
    return df
end

mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide
mlabscore |> prosheet! |> makewide!

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide
quizscore |> prosheet! |> makewide!

itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide
itmbscore |> pswdverify |> prosheet! |> makewide!



pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
pscore |> prosheet! |> makewide!

finaltable0 = outerjoin(password, get_data.(
        [pscore, mlabscore, quizscore, itmbscore]
    )...;
    on=:StudentID)


finaltable = @chain finaltable0 begin
    transform(AsTable(Cols(r"Score\_")) => ByRow(nt -> sum(nt)) => :Final_Score)
    select(:StudentID, :Name, r"Test", r"Score")
end

basictest(finaltable)



# # Send Email
google_password = "$(ARGS[5])" # the password of TA-sender
opt = SendOptions(
    isSSL=true,
    username="tsung.hsi@g.ncu.edu.tw",
    passwd=google_password,
)

url = "smtps://smtp.gmail.com:465"



subject = "基礎程式語言-分數摘要(陳建志老師)"
from = "<tsung.hsi@g.ncu.edu.tw>"

email = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
select!(email, :StudentID, :Email)

function replace_score(str)
    @chain str begin
        replace("Score_CCC" => "(建志-報告)")
        replace("Score_YenYu" => "(彥宇-總分)")
        replace("Score_Quiz" => "(建志-小考)")
        replace("Score_InterMember" => "(建志-報告組內互評)")
        replace("Final_Score" => "(建志-總分)")
    end
end

ft = @chain finaltable begin
    outerjoin(email; on=:StudentID)
    select(:StudentID => "學號", :Name => "姓名", Cols(r"\ATest") .=> identity .=> (x -> "課堂小考 ($(split(x, "_")[end]))"), Cols(r"Score") .=> identity .=> replace_score)
end


for row in eachrow(ft)
    # row = eachrow(ft) |> first
    data = DataFrame(:Field => keys(row), :Content => collect(values(row)))
    io = IOBuffer()
    pretty_table(io, data; backend=Val(:html), standalone=true)
    message = get_mime_msg(HTML(String(take!(io))))
    # rcpt = to = ["<$(row.Email)>"]
    rcpt = to = ["<okatsn@gmail.com>"]# TODO: Change to above before fire.

    # cc = ["<bar@test.com>"]
    # bcc = ["<baz@test.com>"]
    # replyto = "<you@gmail.com>"



    body = get_body(to, from, subject, message) # cc, replyto)
    # Preview the body: String(take!(body)

    # rcpt = vcat(to, cc, bcc)
    resp = send(url, rcpt, from, body, opt)
end
