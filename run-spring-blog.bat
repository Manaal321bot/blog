@echo off
echo Starting Spring Blog Application...

REM Check if JAVA_HOME is set, if not try to find Java
if "%JAVA_HOME%"=="" (
    echo JAVA_HOME not set, trying to find Java installation...
    for /d %%i in ("C:\Program Files\Java\jdk*") do set JAVA_HOME=%%i
    for /d %%i in ("C:\Program Files\Java\jre*") do set JAVA_HOME=%%i
    for /d %%i in ("C:\Program Files (x86)\Java\jdk*") do set JAVA_HOME=%%i
    for /d %%i in ("C:\Program Files (x86)\Java\jre*") do set JAVA_HOME=%%i
)

if "%JAVA_HOME%"=="" (
    echo Java not found. Please install Java 17 or higher and set JAVA_HOME
    pause
    exit /b 1
)

echo Using Java from: %JAVA_HOME%
set PATH=%JAVA_HOME%\bin;%PATH%

echo Cleaning and compiling the project...
call mvnw.cmd clean compile

if %ERRORLEVEL% neq 0 (
    echo Build failed. Please check the errors above.
    pause
    exit /b 1
)

echo Starting the application...
call mvnw.cmd spring-boot:run

pause
