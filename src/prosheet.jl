# SETME: Necessary information in credentials.json for "RawScore" entry is required.
# - Add new struct <: GoogleSheetIdentifier for new entry in dir_local("credentials.json")
@kwdef struct RawScore <: GoogleSheetIdentifier
    keys_to_url = ["RawScore", "url"]
end



"""
`prosheet!(dh::DataHolder)`
"""
function prosheet!(dh::DataHolder)
    set_data!(dh,
        prosheet(
            get_data(dh),
            get_GSID(dh),
        )
    )
end

"""
`makewide!(dh::DataHolder)`
"""
function makewide!(dh::DataHolder)
    set_data!(dh,
        makewide(
            get_data(dh),
            get_GSID(dh),
        )
    )
end

"""
`prosheet(df::DataFrame, RawScore)` processes `df = readgsheet(RawScore)`. It returns `DataFrame`.
"""
function prosheet(df::DataFrame, ::RawScore)
    score2 = @chain df begin
        select(:Test_ID => ByRow(String),
            "Name-ID" => ByRow(str -> String.(split(str, "-"))) => [:Name, :StudentID],
            Cols(r"Quiz") .=> ByRow(Float64) => (x -> replace(x, " " => "")) # Downloaded Google Sheet has an extra whitespace
            ; renamecols=false
        )
        transform(:StudentID => ByRow(str -> parse(Int, str)); renamecols=false)
        stack(Cols(r"Quiz"), [:StudentID, :Test_ID]; variable_name=:Quiz_ID, value_name=:score)
    end

    @assert !any((score2.score .> 100.0) .| (score2.score .< 0.0))
    return score2
end

makewide(df::DataFrame, ::RawScore) = unstack(df, [:StudentID, :Test_ID], :Quiz_ID, :score)
