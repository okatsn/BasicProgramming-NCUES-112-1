module BasicProgrammingNCUES1121

using CSV, DataFrames
include("emaillist.jl")
export lazymaillist

include("projectdir.jl")
export projectdir, dir_temp, dir_local, dir_global, dir_pdf

using JSON, GoogleDrive
include("readgsheet.jl")
export readgsheet, get_data, get_GSID, set_data!
export QuizScore, InterMemberScore, MatlabScore, PresentationScore

using Chain, Statistics
include("prosheet.jl")
export prosheet!, makewide!
include("calculation.jl")
export mean

include("getstid.jl")
export getstid # get ID (Int) for any "Name-ID" string
end
