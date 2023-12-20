using BasicProgrammingNCUES1121, DataFrames#hide
using Chain#hide
using PrettyTables#hide
using Markdown#hide
using Suppressor#hide

gpscore = @suppress readgsheet("https://docs.google.com/spreadsheets/d/YOUR_InterMemberScore_Sheet_IDENTIFIEER/edit?usp=sharing", InterMemberScore()) #hide

score = @suppress readgsheet("https://docs.google.com/spreadsheets/d/YOUR_InterMemberScore_Sheet_IDENTIFIEER/edit?usp=sharing", InterMemberScore()) #hide
