@echo off
Title Obfuscate file with certutil made by RAFOU#8331
color 0A & Mode 83,3
If "%~1"=="" ( 
   color 0C & Mode 80,3
   echo(
   echo       You must drag and drop a file over this batch script to be encoded !
   Timeout /T 4 /nobreak>nul & exit /b
)
@for /f %%i in ("certutil.exe") do if not exist "%%~$path:i" (
  echo CertUtil.exe not found.
  pause
  exit /b
)
 
( 
   echo.
   echo.Del %%~0 
)>tmp.dat

Copy /b "%~1" + tmp.dat /b >nul 2>&1
Del tmp.dat
 
set "TempFile=%Temp%\Temp_b64 
set "OutputFile=%~nx1_encoded%~x0"
set "OutputFile2=%OutputFile%_encoded%~x0
If exist "%OutputFile%" Del "%OutputFile%" >nul 2>&1
echo(
echo         Please wait a while ... Encoding "%~nx1" is in progress ...
certutil.exe -f -encode "%~1" "%TempFile%" >nul 2>&1
(
   echo @echo off 
   echo Title %%~n0
   echo Mode 60,3 
   echo color 0B
   echo echo(
   echo echo         Please wait... a while Loading data ....
   echo CERTUTIL -f -decode "%%~f0" "%%Temp%%\%~nx1" ^>nul 2^>^&1 
   echo cls
   echo "%%Temp%%\%~nx1"
   echo Exit
)>> "%OutputFile%"
copy "%OutputFile%" /b + "%TempFile%" /b >nul 2>&1
>"temp.~b64" echo(//4mY2xzDQo=
certutil.exe -f -decode "temp.~b64" "%OutputFile2%" >nul 2>&1
del "temp.~b64"
copy "%OutputFile2%" /b + "%OutputFile%" /b >nul 2>&1
If exist "%TempFile%" Del "%TempFile%" >nul 2>&1
If exist "%OutputFile%" Del "%OutputFile%" >nul 2>&1
If exist "%OutputFile2%" rename "%OutputFile2%" "%OutputFile%"
Timeout /T 2 /NoBreak>nul & exit