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


df = CSV.read("data/BasicProgrammingStudentList_112-1.csv", DataFrame)



row = eachrow(df) |> first # TODO: remove `first`

# Literate to Markdown
md_name = "$(row.Name)-$(row.StudentID)"
Literate.markdown("scripts/score_overview_template.jl", dir_temp(); preprocess=c -> update_personal(c, row), name=md_name)


# Weave to PDF
weave(joinpath(dir_temp(), md_name * ".md"); informat="markdown", doctype="md2pdf", out_path=dir_temp(), template="textemplate/notosanscjk.tpl")
# KEYNOTE:
# - The default template uses font lmodern. You may need `sudo apt-get install lmodern` if this font is not available yet in your machine. See also the default [md2pdf.tpl in Weave.jl](https://github.com/JunoLab/Weave.jl/blob/master/templates/md2pdf.tpl)
#
# LaTeX support:
# - Font that supports Chinese is required. You may need `sudo apt install fonts-noto-cjk`
# - `ctex` is also required.
# - The easist way is to use https://github.com/okatsn/MyTeXLifeWithJulia, which is based on https://github.com/okatsn/MyTeXLife where `fonts-noto-cjk` is available.

# Add Password to PDF
weavedpdf = joinpath(dir_temp(), md_name * ".pdf")
run_qpdf(row.password, weavedpdf)
# also refer: https://github.com/alexeygumirov/pandoc-for-pdf-how-to#protection-of-pdf-file-with-qpdf
# sudo apt-get update
# # This is for qpdf
# sudo apt-get install qpdf
