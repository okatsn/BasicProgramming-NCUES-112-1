"""
`prosheet(df::DataFrame, ::Type{RawScore})` processes `df = readgsheet(RawScore)`.
"""
function prosheet(df::DataFrame, ::Type{RawScore})
    score2 = @chain df begin
        select(:Test_ID => ByRow(String),
            "Name-ID" => ByRow(str -> String.(split(str, "-"))) => [:Name, :StudentID],
            Cols(r"Quiz") .=> ByRow(Float64) => (x -> replace(x, " " => "")) # Downloaded Google Sheet has an extra whitespace
            ; renamecols=false
        )
        transform(:StudentID => ByRow(str -> parse(Int, str)); renamecols=false)
    end
    return score2
end
