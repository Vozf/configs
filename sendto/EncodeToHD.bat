setlocal enabledelayedexpansion

REM Loop through all command-line arguments
for %%i in (%*) do (
    REM Get the width of the input video
    for /f %%a in ('ffprobe -v error -select_streams v^:0 -show_entries stream^=width -of default^=noprint_wrappers^=1^:nokey^=1 "%%~i"') do (
        set /a width=%%a
    )

    REM Check if width is greater than 1280
    if !width! GTR 1280 (
        REM Resize the video
        ffmpeg -hwaccel cuda -i "%%~i" -c:v hevc_nvenc -vf "scale=1280:-2" -pix_fmt yuv420p -c:a aac -rc:v vbr -cq:v 28 -preset fast "%%~dpi%%~ni_reencoded_hd.mp4"
    ) else (
        REM Keep original size
        ffmpeg -hwaccel cuda -i "%%~i" -c:v hevc_nvenc -c:a aac -rc:v vbr -cq:v 28 -preset fast "%%~dpi%%~ni_reencoded.mp4"
    )
)

pause
