del build\flirt.exe
"C:\Program Files\7-Zip\7z.exe" a -tzip flirt.love -r * -x!build
copy /b "C:\Program Files\LOVE\love.exe"+"flirt.love" "build\flirt.exe"
del flirt.love
build\flirt.exe
