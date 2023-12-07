using CSV, DataFrames, Markdown
using Random
using Chain
using BasicProgrammingNCUES1121
using SMTPClient
using HypertextLiteral # for string interpolation
using Test

# SETME: Confirm before you fire
# df = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
df = CSV.read(projectdir("data", "test_email.csv"), DataFrame)

# Please execute this script via:
# julia --project=@. -e 'include("scripts/calc_score_email.jl")' "your_password"
google_password = "$(ARGS[1])" # the password of TA-sender


opt = SendOptions(
    isSSL=true,
    username="tsung.hsi@g.ncu.edu.tw",
    passwd=google_password,
)

url = "smtps://smtp.gmail.com:465"



subject = "基礎程式語言-組內互評表單與認證碼"
from = "<tsung.hsi@g.ncu.edu.tw>"


# row = eachrow(df) |> first

for row in eachrow(df)
    message = @htl("""
    <p> $(row.StudentID) $(row.Name) 同學您好，以下是您的組內互評表單及認證碼。<br>
    <a href="https://forms.gle/hNmWD61DVKpdD9CM7">組內互評表單連結</a></p>
    <p><strong>請注意</strong>：<br>

    <ul>
    <li>表單需登入Google帳號</li>
    <li>您的驗證碼(3位大寫字母+4位數字)為: $(row.password)</li>
    <li>為了驗證作答者的身分，填答時請務必輸入正確的驗證碼。</li>
    </ul>

    <p>助教 宗羲</p>


    """)

    io = IOBuffer()
    print(io, message)


    message = get_mime_msg(HTML(String(take!(io)))) # do this if message is HTML

    rcpt = to = ["<$(row.Email)>"]
    # cc = ["<bar@test.com>"]
    # bcc = ["<baz@test.com>"]
    # replyto = "<you@gmail.com>"



    body = get_body(to, from, subject, message) # cc, replyto)
    # Preview the body: String(take!(body)

    # rcpt = vcat(to, cc, bcc)
    resp = send(url, rcpt, from, body, opt)

end
