using CSV, DataFrames, Markdown
using Literate, Weave
using Random
using Chain

function update_personal(content, row)
    @chain content begin
        replace("STUDNAME" => row.Name)
        replace("STUDIDNUM" => row.StudentID)
        replace("STUDDEPT" => row.Dept)
    end
end


df = CSV.read("data/BasicProgrammingStudentList_112-1.csv", DataFrame)

temp_dir = "temp" # !!! warning DO NOT push this directory to remote!


# Add password
insertcols!(df, :password => [randstring(rand(5:8)) for _ in 1:nrow(df)])
CSV.write("data/BasicProgrammingStudentList_112-1-password.csv", df)


row = eachrow(df) |> first # TODO: remove `first`

# Literate to Markdown
md_name = "$(row.Name)-$(row.StudentID)"
Literate.markdown("scripts/score_overview_template.jl", temp_dir; preprocess=c -> update_personal(c, row), name=md_name)


# Weave to PDF
weave(joinpath(temp_dir, md_name * ".md"); informat="markdown", doctype="md2pdf", out_path=temp_dir, template="textemplate/notosanscjk.tpl")




command_add_password = """
qpdf --object-streams=disable --encrypt "1234" "1234" 256 --print=none --modify=none --extract=n -- "README_pretty.pdf" "README_password.pdf"
""" # also refer: https://github.com/alexeygumirov/pandoc-for-pdf-how-to#protection-of-pdf-file-with-qpdf
# sudo apt-get update
# # This is for weaving markdown to PDF using default md2pdf.tpl
# sudo apt-get install lmodern
# # This is for qpdf
# sudo apt-get install qpdf
# # This installs noto sans CJK, to allow Chinese characters
# sudo apt install fonts-noto-cjk
