# 課堂測驗成績

## 成績分布

![](score_distribution.png)

## 個人成績查詢

```@eval
using OkFiles, BasicProgrammingNCUES1121, Markdown
flist = filelist(dir_pdf(); join=false) # read pdf in the path of BasicProgrammingNCUES1121
rpath = joinpath.(Ref(".."), Ref("assets"), Ref("pdf"), flist) # A dynamic list of paths to pdf demonstrated on the GitHub Pages; each path is relative to the directory of `docs/src`. # KEYNOTE: If `dir_pdf()` had changed, this path might be invalid.

md0 = Markdown.parse("(若有需求，請向助教查詢密碼)")

for p in rpath
    push!(md0.content, Markdown.Paragraph([Markdown.Link([basename(p)], p)]))
end

md0
```