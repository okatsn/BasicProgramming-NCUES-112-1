## All about processing scores

# !!! note
#     Spreadsheet exclusive definitions reside here.
#     Use interface in `readgsheet`.


# SETME: Necessary information in credentials.json for "QuizScore" entry is required.
# - Add new struct <: GoogleSheetIdentifier for new entry in dir_local("credentials.json")
@kwdef struct QuizScore <: GoogleSheetIdentifier
    keys_to_url = ["QuizScore", "url"]
end

@kwdef struct InterMemberScore <: GoogleSheetIdentifier
    keys_to_url = ["InterMemberScore", "url"]
end

@kwdef struct MatlabScore <: GoogleSheetIdentifier
    keys_to_url = ["MatlabScore", "url"]
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
`prosheet(df::DataFrame, QuizScore)` processes `df = readgsheet(QuizScore())`. It returns `DataFrame`.
"""
function prosheet(df::DataFrame, ::QuizScore)
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

makewide(df::DataFrame, ::QuizScore) = unstack(df, [:StudentID, :Test_ID], :Quiz_ID, :score)
