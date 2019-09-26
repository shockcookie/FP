@ECHO OFF
SETLOCAL EnableExtensions DisableDelayedExpansion

SET "sourcedir=%~1"                               supplied string
if NOT defined sourcedir SET "sourcedir=%CD%"     current directory if nothing supplied

rem basic validity check
if NOT exist "%sourcedir%\*" (
  echo wrong directory "%sourcedir%"
  goto :next 
)
FOR /f "delims=" %%a IN ('dir /b /s /a-d "%sourcedir%\*" ') DO (
  SET "name=%%~na" 
  SETLOCAL ENABLEDELAYEDEXPANSION
      rem     remove ) right parenthesis
  SET "newname=!name:)=!"
      rem        remove ( left parenthesis
  SET "newname=!newname:(=!"
      rem        remove ↓ space(s)
  SET "newname=!newname: =!"
  IF "!name!" neq "!newname!" (
      IF EXIST "%%~dpa!newname!%%~xa" (
        ECHO cannot RENAME %%a
      ) ELSE (
        rem operational RENAME command is merely ECHO-ed for debugging purposes 
        RENAME "%%a" "!newname!%%~xa"
      )
  )
  ENDLOCAL
)
:next
rem pause to see output 
pause