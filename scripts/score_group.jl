# KEYNOTE: #src
# - Please refer literate_score_group.jl for generating the markdown document for CI and page. #src

# # 課堂測驗成績
#
# ## 成績分布
#
# ![](score_distribution.png)
#
# ## 組內互評摘要

# 請依照說明對同組組員進行評分：
# ![](how_to_score_your_member.png)

using CairoMakie, AlgebraOfGraphics #hide
using BasicProgrammingNCUES1121, DataFrames#hide
using Chain#hide
using PrettyTables#hide
using HypertextLiteral#hide
using Markdown#hide
using Suppressor#hide

# # An example for ARGS: #src
# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; #src
# YOUR_InterMemberScore_Sheet_IDENTIFIEER = ARGS[1] #src

# KEYNOTE: Suppressor is required otherwise google sheet url will be printed. #src
cloudscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/YOUR_InterMemberScore_Sheet_IDENTIFIEER/edit?usp=sharing", InterMemberScore()) #hide
# # In your local machine: #src
# cloudscore = readgsheet(InterMemberScore()) #src
# prosheet!(cloudscore) #src

function mdtable1(df) #hide
    io = IOBuffer() #hide
    pretty_table(io, df; backend=Val(:markdown), header=names(df)) #hide
    Markdown.parse(String(take!(io))) #hide
end #hide
mdtable2(df) = @htl "$df" #hide
score = cloudscore.data #hide
score1 = select(score, #hide
    "電子郵件地址" => :Email, #hide
    "認證碼" => :passkey, #hide
    "評分者姓名(我的名字)" => :Evaluator, #hide
    "被評者姓名(組員姓名)" => :Evaluatee #hide
) #hide
nothing #hide

# ### 評分者摘要

tb1 = @chain score1 begin #hide
    groupby(:Evaluator) #hide
    combine(nrow => "已評組員數") #hide
end #hide
mdtable1(tb1) #hide


# ### 受評者摘要

tb2 = @chain score1 begin #hide
    groupby(:Evaluatee) #hide
    combine(nrow => "被評次數") #hide
end #hide
mdtable1(tb2) #hide
