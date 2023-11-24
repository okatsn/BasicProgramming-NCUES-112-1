# This script read data, based on the template of Literate generate Julia Markdown, and weave
# the Julia Markdown as PDF. Please also refer `literate_template`.
# # KEYNOTE:
# - `weave` with `doctype=md2pdf` can run only in the environment where LaTeX and related packages were available, such as `MyTeXLifeWithJulia`. Github actions will easily fail if the environment have not been correctly set up.
# - The default template ([md2pdf.tpl in Weave.jl](https://github.com/JunoLab/Weave.jl/blob/master/templates/md2pdf.tpl)) uses font lmodern; it will fail if this font is not found in your system. `sudo apt-get install lmodern` do the installation of the font. Noted that this font does not support Chinese.
# - To support Chinese, use `sudo apt install fonts-noto-cjk`.
# - `ctex` is also required.
# - The easist way is to use https://github.com/okatsn/MyTeXLifeWithJulia, which is based on https://github.com/okatsn/MyTeXLife where `fonts-noto-cjk` is available.
# !!! note Currently you cannot execute this script in CI.yml
#     * This cannot be done since this script (the weave part) not only depends on julia, but also depends on
#       qpdf and a lot of LaTeX things.
# CHECKPOINT: Run container MyTeXLifeWithJulia in CI.yml
# - Currently it failed at `actions/checkout@v3` with "Error: EACCES: permission denied".
using CSV, DataFrames, Markdown
using Literate, Weave
using Random
using Chain
using BasicProgrammingNCUES1121
using Test

# Name
literate_template = projectdir("scripts", "score_overview_template.jl")
latex_template = projectdir("textemplate", "notosanscjk.tpl")
localtable = CSV.read(projectdir("data", "BasicProgrammingStudentList_112-1.csv"), DataFrame)
mkpath(dir_pdf())

# Hint: You can move codes in literate_template for debug purposes.


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


row = eachrow(localtable) |> first # TODO: remove `first`

for row in eachrow(localtable)
    # Literate to Markdown
    md_name = "$(row.StudentID)"
    Literate.markdown(literate_template, dir_temp(); preprocess=c -> update_personal(c, row), name=md_name)


    # Weave to PDF
    weave(joinpath(dir_temp(), md_name * ".md"); informat="markdown", doctype="md2pdf", out_path=dir_temp(), template=latex_template, latex_cmd=["xelatex", "-shell-escape", "-halt-on-error"])

    # Add Password to PDF
    weavedpdf = dir_temp(md_name * ".pdf")
    run_qpdf(row.password, weavedpdf)
    # also refer: https://github.com/alexeygumirov/pandoc-for-pdf-how-to#protection-of-pdf-file-with-qpdf
    # sudo apt-get update
    # # This is for qpdf
    # sudo apt-get install qpdf
    mv(weavedpdf, dir_pdf(md_name * ".pdf"), force=true)
end
