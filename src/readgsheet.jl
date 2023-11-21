# refer: https://docs.julialang.org/en/v1/manual/types/#Parametric-Abstract-Types
abstract type GoogleSheetIdentifier end

get_keys_to_url(GSID::GoogleSheetIdentifier) = GSID.keys_to_url

"""
```
mutable struct DataHolder
    data::DataFrame
    GSID::GoogleSheetIdentifier
end
```
"""
mutable struct DataHolder
    data::DataFrame
    GSID::GoogleSheetIdentifier
end

get_data(dh::DataHolder) = dh.data;
get_GSID(dh::DataHolder) = dh.GSID;

set_data!(dh::DataHolder, data) = setfield!(dh, :data, data)

"""
Given `GSID<:GoogleSheetIdentifier`, `readgsheet(GSID::GoogleSheetIdentifier)` returns a `DataHolder` storing the data obtained from the google sheet. The "url" in `dir_local("credentials.json")` must be set public.

# Example
Read data on cloud in `dir_local("credentials.json")` at entry `["RawScore"]["url"]`.

```julia
readgsheet(RawScore())
```

This function depends on `GoogleDrive.jl`, it is designed to work with DVC to ensure secret data/path/url won't be push to public.

Noted that there is another package [GoogleSheets.jl](https://github.com/chipkent/GoogleSheets.jl). However, this requires more complex pre settings:
- Enable Google Sheets API:
    - Create a new project or select an existing one in [Google Cloud Console](https://console.cloud.google.com/).
    - [Create OAuth client ID and enable the Google Sheets API for your project](https://developers.google.com/sheets/api/quickstart/python?hl=zh-tw).
    - Create credentials for the API and download the JSON file, and follow the example of GoogleSheets.jl

"""
function readgsheet(GSID::GoogleSheetIdentifier)
    json = JSON.parsefile(projectdir("local", "credentials.json"))
    fs = map(key -> (d -> getindex(d, key)), reverse(BasicProgrammingNCUES1121.get_keys_to_url(GSID)))
    url = ∘(fs...)(json) # recursively getindex by key in get_keys_to_url(GSID)
    temp = mktempdir()
    csvsheet = google_download(url, temp)
    rawscore = CSV.read(csvsheet, DataFrame)
    return DataHolder(rawscore, GSID)
end
