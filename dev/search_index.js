var documenterSearchIndex = {"docs":
[{"location":"score/#課堂測驗成績","page":"課堂測驗成績","title":"課堂測驗成績","text":"","category":"section"},{"location":"score/#成績分布","page":"課堂測驗成績","title":"成績分布","text":"","category":"section"},{"location":"score/","page":"課堂測驗成績","title":"課堂測驗成績","text":"(Image: )","category":"page"},{"location":"score/#個人成績查詢","page":"課堂測驗成績","title":"個人成績查詢","text":"","category":"section"},{"location":"score/","page":"課堂測驗成績","title":"課堂測驗成績","text":"# # Generate a list of PDF files\n# This script won't be executed since the syntax `@eval` is not applied.\nusing OkFiles, BasicProgrammingNCUES1121, Markdown\nflist = filelist(dir_pdf(); join=false) # read pdf in the path of BasicProgrammingNCUES1121\nrpath = joinpath.(Ref(\"..\"), Ref(\"assets\"), Ref(\"pdf\"), flist) # A dynamic list of paths to pdf demonstrated on the GitHub Pages; each path is relative to the directory of `docs/src`. # KEYNOTE: If `dir_pdf()` had changed, this path might be invalid.\n\nmd0 = Markdown.parse(\"(若有需求，請向助教查詢密碼)\")\n\nfor p in rpath\n    push!(md0.content, Markdown.Paragraph([Markdown.Link([basename(p)], p)]))\nend\n\nmd0","category":"page"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"EditURL = \"../../scripts/score_group.jl\"","category":"page"},{"location":"score_group/#課堂測驗成績","page":"課堂測驗成績","title":"課堂測驗成績","text":"","category":"section"},{"location":"score_group/#成績分布","page":"課堂測驗成績","title":"成績分布","text":"","category":"section"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"(Image: )","category":"page"},{"location":"score_group/#組內互評摘要","page":"課堂測驗成績","title":"組內互評摘要","text":"","category":"section"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"\n\n\n","category":"page"},{"location":"score_group/#評分者摘要","page":"課堂測驗成績","title":"評分者摘要","text":"","category":"section"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"<div><div style = \"float: left;\"><span>0×2 DataFrame</span></div><div style = \"clear: both;\"></div></div><div class = \"data-frame\" style = \"overflow-x: scroll;\"><table class = \"data-frame\" style = \"margin-bottom: 6px;\"><thead><tr class = \"header\"><th class = \"rowNumber\" style = \"font-weight: bold; text-align: right;\">Row</th><th style = \"text-align: left;\">Evaluator</th><th style = \"text-align: left;\">已評組員數</th></tr><tr class = \"subheader headerLastRow\"><th class = \"rowNumber\" style = \"font-weight: bold; text-align: right;\"></th><th title = \"Missing\" style = \"text-align: left;\">Missing</th><th title = \"Int64\" style = \"text-align: left;\">Int64</th></tr></thead><tbody></tbody></table></div>","category":"page"},{"location":"score_group/#受評者摘要","page":"課堂測驗成績","title":"受評者摘要","text":"","category":"section"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"<div><div style = \"float: left;\"><span>0×2 DataFrame</span></div><div style = \"clear: both;\"></div></div><div class = \"data-frame\" style = \"overflow-x: scroll;\"><table class = \"data-frame\" style = \"margin-bottom: 6px;\"><thead><tr class = \"header\"><th class = \"rowNumber\" style = \"font-weight: bold; text-align: right;\">Row</th><th style = \"text-align: left;\">Evaluatee</th><th style = \"text-align: left;\">被評次數</th></tr><tr class = \"subheader headerLastRow\"><th class = \"rowNumber\" style = \"font-weight: bold; text-align: right;\"></th><th title = \"Missing\" style = \"text-align: left;\">Missing</th><th title = \"Int64\" style = \"text-align: left;\">Int64</th></tr></thead><tbody></tbody></table></div>","category":"page"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"","category":"page"},{"location":"score_group/","page":"課堂測驗成績","title":"課堂測驗成績","text":"This page was generated using Literate.jl.","category":"page"},{"location":"info/#課程須知","page":"課程須知","title":"課程須知","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"基礎程式語言第二部分(陳建志老師)課程須知 (草案)","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"上課時間：週一 15:00-17:00","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗：共四次隨堂上機測驗。詳細時間見測驗時間、範圍與流程。","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗題庫：Python for beginners","category":"page"},{"location":"info/#測驗與計分方式","page":"課程須知","title":"測驗與計分方式","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗題目將從 Python for beginners 在指定範圍內抽選。\n每次測驗將包含2個由助教指定的測驗頁面項目；測驗分數為這兩個頁面上的分數平均。","category":"page"},{"location":"info/#測驗時間、範圍與流程","page":"課程須知","title":"測驗時間、範圍與流程","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗時間與範圍如下：","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"日期 範圍 附註\n11/20 15:00 Python for beginners (1) - (4) (4 抽 2)\n12/04 15:00 Python for beginners (5) - (8) (4 抽 2)\n12/25 15:00 Python for beginners (9) - (12) (4 抽 2)\n01/08 15:00 Python for beginners (13) - (16) (4 抽 2)","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"每次測驗為50分鐘，包含以下流程：","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"說明與分發測驗頁面編號 (5分)\n上機考試 (40分)\n登記分數與緩衝時間 (5分)","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"note: Note\n作答完畢即可舉手請助教過去登記成績。","category":"page"},{"location":"info/","page":"課程須知","title":"課程須知","text":"warning: Warning\n作答完畢後，請務必等待助教成績登記完成，才能關閉測驗頁面。","category":"page"},{"location":"info/#測驗規定","page":"課程須知","title":"測驗規定","text":"","category":"section"},{"location":"info/#測驗中","page":"課程須知","title":"測驗中","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗中不能開啟測驗頁面以外的分頁或視窗。以下為範例但不限於：\n不能使用Google、ChatGPT尋找答案\n一旦進入測驗頁面就不能再回去課程教學頁面。\n其他未經允許事項一律預設為不行。以下為範例但不限於：\n不能使用手機、戴耳機或操作其他電子設備。\n不能看書或紙本文件。\n請在測驗日上機前上完廁所。測驗頁面開啟後，一旦離座就算考試結束。\n因緊急與不可抗力事件無法參加或完成測驗，得視情況安排補考。","category":"page"},{"location":"info/#作弊與違規","page":"課程須知","title":"作弊與違規","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"若發現作弊，則當天之測驗分數將全部計為零分，並視情況送學務處處理。\n違規事項可能會被視為作弊。","category":"page"},{"location":"info/#請假與補考","page":"課程須知","title":"請假與補考","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"因故無法參與考試，請在考試3天前寄信或找助教完成請假程序。聯絡方式詳見助教與問題回報。\n未經請假而缺席，則當次測驗計為零分。\n除非突發、來不及反應之事件，否則不接受事後請假。\n事後請假需附證明文件。","category":"page"},{"location":"info/#附註","page":"課程須知","title":"附註","text":"","category":"section"},{"location":"info/#測驗頁面","page":"課程須知","title":"測驗頁面","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"測驗頁面係指 Python for beginners 的 1-16個課程最後的 \"Python 練習\" ➡️ Quiz。","category":"page"},{"location":"info/#助教與問題回報","page":"課程須知","title":"助教與問題回報","text":"","category":"section"},{"location":"info/","page":"課程須知","title":"課程須知","text":"助教是吳宗羲，你可以在科學一館 S113 找到助教，或經電子郵件聯絡 (tsung.hsi@ncu.edu.tw)。","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = BasicProgrammingNCUES1121","category":"page"},{"location":"#基礎程式設計","page":"Home","title":"基礎程式設計","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"這是2023年11月13日開始的，由陳建志老師教授的基礎程式語言課程(GA1002)資訊頁面。 請務必閱讀 課程須知。 若有任何問題，請參照助教與問題回報。","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [BasicProgrammingNCUES1121]","category":"page"},{"location":"#BasicProgrammingNCUES1121.DataHolder","page":"Home","title":"BasicProgrammingNCUES1121.DataHolder","text":"mutable struct DataHolder\n    data::DataFrame\n    GSID::GoogleSheetIdentifier\nend\n\n\n\n\n\n","category":"type"},{"location":"#BasicProgrammingNCUES1121.lazymaillist-Tuple{Any}","page":"Home","title":"BasicProgrammingNCUES1121.lazymaillist","text":"lazymaillist(path) read the CSV file's \"Email\" column, and returns a string of addresses separated by comma (for GMail) by default.\n\n\n\n\n\n","category":"method"},{"location":"#BasicProgrammingNCUES1121.lazymaillist-Tuple{}","page":"Home","title":"BasicProgrammingNCUES1121.lazymaillist","text":"lazymaillist() reads CSV in ./data/BasicProgrammingStudentList_112-1.csv. It will fail if the current directory is wrong or there is no such data (dvc pulled?).\n\n\n\n\n\n","category":"method"},{"location":"#BasicProgrammingNCUES1121.makewide!-Tuple{BasicProgrammingNCUES1121.DataHolder}","page":"Home","title":"BasicProgrammingNCUES1121.makewide!","text":"makewide!(dh::DataHolder)\n\n\n\n\n\n","category":"method"},{"location":"#BasicProgrammingNCUES1121.prosheet!-Tuple{BasicProgrammingNCUES1121.DataHolder}","page":"Home","title":"BasicProgrammingNCUES1121.prosheet!","text":"prosheet!(dh::DataHolder)\n\n\n\n\n\n","category":"method"},{"location":"#BasicProgrammingNCUES1121.prosheet-Tuple{DataFrames.DataFrame, RawScore}","page":"Home","title":"BasicProgrammingNCUES1121.prosheet","text":"prosheet(df::DataFrame, RawScore) processes df = readgsheet(RawScore()). It returns DataFrame.\n\n\n\n\n\n","category":"method"},{"location":"#BasicProgrammingNCUES1121.readgsheet-Tuple{BasicProgrammingNCUES1121.GoogleSheetIdentifier}","page":"Home","title":"BasicProgrammingNCUES1121.readgsheet","text":"Given GSID<:GoogleSheetIdentifier, readgsheet(GSID::GoogleSheetIdentifier) returns a DataHolder storing the data obtained from the google sheet. GSID must contain keys to url for indexing into  dir_local(\"credentials.json\") to get the url. The url in dir_local(\"credentials.json\") must be public.\n\nExample\n\nRead data on cloud in dir_local(\"credentials.json\") at entry [\"RawScore\"][\"url\"].\n\nreadgsheet(RawScore())\n\nThis function depends on GoogleDrive.jl, it is designed to work with DVC to ensure secret data/path/url won't be push to public.\n\nNoted that there is another package GoogleSheets.jl. However, this requires more complex pre settings:\n\nEnable Google Sheets API:\nCreate a new project or select an existing one in Google Cloud Console.\nCreate OAuth client ID and enable the Google Sheets API for your project.\nCreate credentials for the API and download the JSON file, and follow the example of GoogleSheets.jl\n\n\n\n\n\n","category":"method"}]
}
