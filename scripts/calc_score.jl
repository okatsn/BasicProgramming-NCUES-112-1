# This script read data, based on the template of Literate generate Julia Markdown, and weave
# the Julia Markdown as PDF.

using CSV, DataFrames, Markdown
using Literate, Weave
using Random
using Chain
using BasicProgrammingNCUES1121
using Test

# Name
literate_template = projectdir("scripts", "score_overview_template.jl")
latex_template = projectdir("textemplate", "notosanscjk.tpl")
data_name = projectdir("data", "BasicProgrammingStudentList_112-1.csv")
df = CSV.read(data_name, DataFrame)

# select(df, :Row, :Dept, :StudentID, :Name, :Gender , Cols(r"Email"))

# Download latest google sheet

rawscore = readgsheet("rawScore")
score2 = @chain rawscore begin
    select(:Test_ID => ByRow(String),
        "Name-ID" => ByRow(str -> String.(split(str, "-"))) => [:Name, :StudentID],
        Cols(r"Quiz") .=> ByRow(Float64) => (x -> replace(x, " " => "")) # Downloaded Google Sheet has an extra whitespace
        ; renamecols=false
    )
    transform(:StudentID => ByRow(str -> parse(Int, str)); renamecols=false)
end


for col in eachcol(select(score2, r"Quiz"))
    @assert !any((col .> 100.0) .| (col .< 0.0))
end # CHECK score range.


# Combine
df2 = outerjoin(df, score2; on=[:StudentID, :Name])
disallowmissing!(df2, Not(r"Quiz")) # Make sure there is no missing values
sort!(df2, :Row)
CSV.write(dir_temp("temp.csv"), df2)

# transform(df2, AsTable(:Test_ID, :Quiz_A, :Quiz_B) => (nt -> )) # CHECKPOINT: Incorporate/Update the score sheet.


function update_personal(content, row)
    @chain content begin
        replace("STUDNAME" => row.Name)
        replace("STUDIDNUM" => row.StudentID)
        replace("STUDDEPT" => row.Dept)
    end
end

function run_qpdf(password, src, dest)
    command_add_password = `qpdf --object-streams=disable --encrypt "$password" "$password" 256 --print=none --modify=none --extract=n -- "$src" "$dest"`
    # The first password is user password (allows open)
    # The second password is owner password (allows edit)
    run(command_add_password)
end

function run_qpdf(password, src)
    command_add_password = `qpdf --object-streams=disable --encrypt "$password" "$password" 256 --print=none --modify=none --extract=n -- "$src" --replace-input`
    # --replace-input is required to say that I'm intended to replace the original file with the encrypted one
    # with --replace-input, you cannont assign dest.
    run(command_add_password)
end


row = eachrow(df2) |> first # TODO: remove `first`

# Literate to Markdown
md_name = "$(row.Name)-$(row.StudentID)"
Literate.markdown(literate_template, dir_temp(); preprocess=c -> update_personal(c, row), name=md_name)


# Weave to PDF
weave(joinpath(dir_temp(), md_name * ".md"); informat="markdown", doctype="md2pdf", out_path=dir_temp(), template=latex_template)
# KEYNOTE:
# - The default template uses font lmodern. You may need `sudo apt-get install lmodern` if this font is not available yet in your machine. See also the default [md2pdf.tpl in Weave.jl](https://github.com/JunoLab/Weave.jl/blob/master/templates/md2pdf.tpl)
#
# LaTeX support:
# - Font that supports Chinese is required. You may need `sudo apt install fonts-noto-cjk`
# - `ctex` is also required.
# - The easist way is to use https://github.com/okatsn/MyTeXLifeWithJulia, which is based on https://github.com/okatsn/MyTeXLife where `fonts-noto-cjk` is available.

# Add Password to PDF
weavedpdf = dir_temp(md_name * ".pdf")
run_qpdf(row.password, weavedpdf)
# also refer: https://github.com/alexeygumirov/pandoc-for-pdf-how-to#protection-of-pdf-file-with-qpdf
# sudo apt-get update
# # This is for qpdf
# sudo apt-get install qpdf
