
projectdir(args...) = joinpath(dirname(dirname(pathof(BasicProgrammingNCUES1121))), args...)
dir_temp(args...) = projectdir("temp", args...)
dir_local(args...) = projectdir("local", args...)
dir_global(args...) = projectdir("global", args...)
