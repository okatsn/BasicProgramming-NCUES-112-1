
"""
`lazymaillist(path)` read the CSV file's "Email" column, and returns a string of addresses separated by comma (for GMail) by default.
"""
function lazymaillist(path; delimiter = ",")
    df = CSV.read(path, DataFrame)
    join(df.Email, delimiter)
end

naivepath = "./data/BasicProgrammingStudentList_112-1.csv"

"""
`lazymaillist()` reads CSV in $naivepath. It will fail if the current directory is wrong or there is no such data (`dvc pull`ed?).
"""
function lazymaillist()
    lazymaillist(naivepath)
end
