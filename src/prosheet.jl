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
        stack(Cols(r"Quiz"), [:StudentID, :Test_ID]; variable_name=:Quiz_ID, value_name=:score)
    end

    @assert !any((score2.score .> 100.0) .| (score2.score .< 0.0))
    return score2
end
