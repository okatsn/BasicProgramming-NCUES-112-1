module BasicProgrammingNCUES1121

using CSV, DataFrames
include("emaillist.jl")
export lazymaillist

include("projectdir.jl")
export projectdir, dir_temp, dir_local, dir_global, dir_pdf

using JSON, GoogleDrive
include("readgsheet.jl")
export readgsheet, get_data, get_GSID, set_data!
export RawScore, GroupScore

using Chain
include("prosheet.jl")
export prosheet!, makewide!
end
