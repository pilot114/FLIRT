SET zpath="C:\Program Files\7-Zip\7z.exe"
SET lovedir="C:\Program Files\LOVE"

IF exist build (
	del build\flirt.exe
	%zpath% a -tzip flirt.love -r * -x!build
	if %errorlevel%==9009 pause

	copy /b %lovedir%"\love.exe"+"flirt.love" "build\flirt.exe"
	if %errorlevel%==9009 pause

	del flirt.love
	build\flirt.exe
) ELSE (
	mkdir build
	xcopy %lovedir%\*.dll build
)
