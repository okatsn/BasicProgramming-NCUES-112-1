module BasicProgrammingNCUES1121

using CSV, DataFrames
include("emaillist.jl")
export lazymaillist

include("projectdir.jl")
export projectdir, dir_temp

using JSON, GoogleDrive
include("readgsheet.jl")
export readgsheet, RawScore, get_data, get_GSID, set_data!

using Chain
include("prosheet.jl")
export prosheet!, makewide!
end
