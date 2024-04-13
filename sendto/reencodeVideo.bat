setlocal enabledelayedexpansion

REM Loop through all command-line arguments
for %%i in (%*) do (
    REM Run ffmpeg command to re-encode each video to Full HD resolution
    ffmpeg -hwaccel cuda -i "%%~i" -c:v h264_nvenc -vf "scale=1920:1080" -pix_fmt yuv420p -c:a aac -crf 28 -preset fast "%%~dpi%%~ni_small%%~xi"
)

pause
