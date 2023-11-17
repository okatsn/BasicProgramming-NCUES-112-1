
projectdir(args...) = joinpath(dirname(dirname(pathof(BasicProgrammingNCUES1121))), args...)
dir_temp(args...) = projectdir("temp", args...)
