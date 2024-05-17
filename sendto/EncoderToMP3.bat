setlocal enabledelayedexpansion

REM Loop through all command-line arguments
for %%i in (%*) do (
        ffmpeg -i "%%~i" -c:v hevc_nvenc -vn -ar 44100 -ac 2 -b:a 320k  "%%~dpi%%~ni.mp3"
)

pause