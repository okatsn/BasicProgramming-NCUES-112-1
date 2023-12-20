using BasicProgrammingNCUES1121, DataFrames#hide
using Statistics
using Chain#hide
using PrettyTables#hide
using Markdown#hide
using Suppressor#hide


mlabscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[1])/edit?usp=sharing", MatlabScore()) #hide

quizscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[2])/edit?usp=sharing", QuizScore()) #hide

prosheet!(quizscore)
makewide!(quizscore)



itmbscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[3])/edit?usp=sharing", InterMemberScore()) #hide

pscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/$(ARGS[4])/edit?usp=sharing", PresentationScore()) #hide
