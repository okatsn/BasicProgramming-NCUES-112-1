module BasicProgrammingNCUES1121

using CSV, DataFrames
include("emaillist.jl")
export lazymaillist

include("projectdir.jl")
export projectdir, dir_temp

using JSON, GoogleDrive
include("readgsheet.jl")
export readgsheet

end
