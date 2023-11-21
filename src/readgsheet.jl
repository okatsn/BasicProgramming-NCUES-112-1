"""
Given `key_in_credentials`, `readgsheet` returns a DataFrame of the google sheet. The "url" in `dir_local("credentials.json")` must be set public.

# Example
```julia
readgsheet("rawScore")
```

This function depends on `GoogleDrive.jl`, it is designed to work with DVC to ensure secret data/path/url won't be push to public.

Noted that there is another package [GoogleSheets.jl](https://github.com/chipkent/GoogleSheets.jl). However, this requires more complex pre settings:
- Enable Google Sheets API:
    - Create a new project or select an existing one in [Google Cloud Console](https://console.cloud.google.com/).
    - [Create OAuth client ID and enable the Google Sheets API for your project](https://developers.google.com/sheets/api/quickstart/python?hl=zh-tw).
    - Create credentials for the API and download the JSON file, and follow the example of GoogleSheets.jl

"""
function readgsheet(key_in_credentials)
    url = JSON.parsefile(projectdir("local", "credentials.json"))[key_in_credentials]["url"]
    temp = mktempdir()
    csvsheet = google_download(url, temp)
    rawscore = CSV.read(csvsheet, DataFrame)
    return rawscore
end
