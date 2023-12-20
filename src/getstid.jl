"""
get ID (Int) for any "Name-ID" string
"""
getstid(str) = split(str, "-") |> last |> str -> parse(Int, str)
