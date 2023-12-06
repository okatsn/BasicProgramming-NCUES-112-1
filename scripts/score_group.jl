# KEYNOTE: #src
# - Please refer literate_score_group.jl for generating the markdown document for CI and page. #src

# # 課堂測驗成績
#
# ## 成績分布
#
# ![](score_distribution.png)
#
# ## 組內互評摘要


using CairoMakie, AlgebraOfGraphics #hide
using BasicProgrammingNCUES1121, DataFrames#hide
using Chain#hide

# # An example for ARGS: #src
# ARGS = ["https://docs.google.com/spreadsheets/d/XXXX/edit?usp=sharing"]; #src
# YOUR_GroupScore_Sheet_IDENTIFIEER = ARGS[1] #src

cloudscore = readgsheet("https://docs.google.com/spreadsheets/d/YOUR_GroupScore_Sheet_IDENTIFIEER/edit?usp=sharing", GroupScore()) #hide
# # In your local machine: #src
# cloudscore = readgsheet(GroupScore()) #src

# CHECKPOINT: No method supports prosheet yet #src
# prosheet!(cloudscore) #src

score = cloudscore.data #hide
score1 = select(score, #hide
    "電子郵件地址" => :Email, #hide
    "認證碼" => :passkey, #hide
    "評分者姓名(我的名字)" => :Evaluator, #hide
    "被評者姓名(組員姓名)" => :Evaluatee #hide
) #hide

### 評分者摘要

tb1 = @chain score1 begin #hide
    groupby(:Evaluator) #hide
    combine(nrow => "已評組員數") #hide
end #hide


#-

### 受評者摘要

tb2 = @chain score1 begin #hide
    groupby(:Evaluatee) #hide
    combine(nrow => "被評次數") #hide
end #hide