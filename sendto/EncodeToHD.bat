setlocal enabledelayedexpansion

REM Loop through all command-line arguments
for %%i in (%*) do (
    REM Get the resolution of the input video
    for /f "tokens=1,2 delims=x" %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "%%~i" 2^>^&1') do (
        set /a width=%%a
        set /a height=%%b
    )

    REM Check if width is greater than 1280 or height is greater than 720
    if !width! gtr 1280 (
        REM Resize the video
        ffmpeg -hwaccel cuda -i "%%~i" -c:v hevc_nvenc -vf "scale=1280:-2" -pix_fmt yuv420p -c:a aac -rc:v vbr -cq:v 28 -preset fast "%%~dpi%%~ni_reencoded.mp4"
    ) else (
        REM Keep original size
        ffmpeg -hwaccel cuda -i "%%~i" -c:v hevc_nvenc -c:a aac -rc:v vbr -cq:v 28 -preset fast "%%~dpi%%~ni_reencoded.mp4"
    )
)

pause
