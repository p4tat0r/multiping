@echo off 

setlocal enableextensions enabledelayedexpansion

del temp.txt
set list= google.com lemonde.fr wikipedia.org ibm.com laredoute.fr perdu.com danstonchat.com tutorialspoint.com startpage.com docker.com

for %%a in (%list%) do (
	CALL :multiping %%a
)

goto :end

:multiping
SET _cmd=ping -n 1 %~1
FOR /f "tokens=4 delims=(=" %%T IN ('%_cmd% ^|find "Minimum "') DO (
	REM Here just because I couldn't trim the time with the find command, which results in the %G% variable
	call :Trim tempPing %%T
	REM Here adding padding of zeroes, I assume if a website takes more than 10 seconds to answer to ping, it's down
	set tempPing=000!tempPing!
	REM Here taking only 6 characters (4 numbers + 'ms'), so I trim the zeroes that are useless
	set tempPing=!tempPing:~-6!
	REM Here sending the time followed by a dash and followed by the name of the site, which was passed as first param
	echo !tempPing! - %~1 >> temp.txt
)

:Trim
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
REM You can comment the line here under in order to have a progress for each ping
exit /b

:end
cls
sort temp.txt

exit /B 0

