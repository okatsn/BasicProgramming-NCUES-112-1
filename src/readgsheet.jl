"""
Given `key_in_credentials`, `readgsheet` returns a DataFrame of the google sheet. The "url" in `dir_local("credentials.json")` must be set public.

# Example
```julia
readgsheet("rawScore")
```
"""
function readgsheet(key_in_credentials)
    url = JSON.parsefile(projectdir("local", "credentials.json"))[key_in_credentials]["url"]
    temp = mktempdir()
    csvsheet = google_download(url, temp)
    rawscore = CSV.read(csvsheet, DataFrame)
    return rawscore
end
