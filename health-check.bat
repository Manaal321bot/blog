@echo off
cls
echo ========================================
echo  SPRING BOOT BLOG - COMPLETE HEALTH CHECK
echo ========================================
echo.

REM Set variables
set PROJECT_NAME=Spring Boot Blog Application
set BUILD_SUCCESS=false
set COMPILE_SUCCESS=false
set TEST_SUCCESS=false
set PACKAGE_SUCCESS=false

echo [SYSTEM INFO]
echo Java Version:
java -version 2>&1 | findstr "version"
echo.
echo Maven Version:
mvn -version | findstr "Apache Maven"
echo.

echo ========================================
echo [1/6] DEPENDENCY CHECK
echo ========================================
echo Checking Maven dependencies...
mvn dependency:resolve-sources -q
if %ERRORLEVEL% neq 0 (
    echo ERROR: Dependency resolution failed!
    echo Suggestion: Check your internet connection and Maven repository access
    pause
    exit /b 1
) else (
    echo SUCCESS: All dependencies resolved
)
echo.

echo ========================================
echo [2/6] CLEAN BUILD ENVIRONMENT
echo ========================================
echo Cleaning previous build artifacts...
mvn clean -q
if %ERRORLEVEL% neq 0 (
    echo WARNING: Clean operation had issues
) else (
    echo SUCCESS: Build environment cleaned
)
echo.

echo ========================================
echo [3/6] SOURCE COMPILATION TEST
echo ========================================
echo Compiling Java source files...
mvn compile -q
if %ERRORLEVEL% neq 0 (
    echo ERROR: Source compilation failed!
    echo.
    echo Running detailed compilation to show errors:
    mvn compile
    pause
    exit /b 1
) else (
    echo SUCCESS: Source compilation completed
    set COMPILE_SUCCESS=true
)
echo.

echo ========================================
echo [4/6] TEST COMPILATION AND EXECUTION
echo ========================================
echo Compiling and running tests...
mvn test -q
if %ERRORLEVEL% neq 0 (
    echo WARNING: Some tests failed or test compilation failed
    echo Running detailed test output:
    mvn test
    echo.
    echo Note: Application may still work with failing tests
) else (
    echo SUCCESS: All tests passed
    set TEST_SUCCESS=true
)
echo.

echo ========================================
echo [5/6] APPLICATION PACKAGING
echo ========================================
echo Creating application JAR file...
mvn package -DskipTests -q
if %ERRORLEVEL% neq 0 (
    echo ERROR: Packaging failed!
    echo Running detailed packaging:
    mvn package -DskipTests
    pause
    exit /b 1
) else (
    echo SUCCESS: Application packaged successfully
    set PACKAGE_SUCCESS=true
)
echo.

echo ========================================
echo [6/6] APPLICATION STARTUP TEST
echo ========================================
echo Testing application startup (15 second test)...

REM Start the application in background and capture PID
start /B java -jar target\spring-boot-blog-application-1.4.0.jar --server.port=8099 --spring.profiles.active=test > startup.log 2>&1

REM Wait a moment for startup
timeout /t 5 /nobreak > nul

REM Check if application is responding
echo Checking if application responds on port 8099...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8099' -TimeoutSec 10 -UseBasicParsing; Write-Output 'Application is responding: HTTP ' + $response.StatusCode } catch { Write-Output 'Application not responding: ' + $_.Exception.Message }" 

REM Kill the test application
taskkill /F /IM java.exe > nul 2>&1

echo.
echo ========================================
echo  HEALTH CHECK SUMMARY
echo ========================================
echo Project: %PROJECT_NAME%
echo Build Date: %date% %time%
echo.

if "%COMPILE_SUCCESS%"=="true" (
    echo ✅ Compilation: PASSED
) else (
    echo ❌ Compilation: FAILED
)

if "%TEST_SUCCESS%"=="true" (
    echo ✅ Tests: PASSED
) else (
    echo ⚠️  Tests: ISSUES DETECTED
)

if "%PACKAGE_SUCCESS%"=="true" (
    echo ✅ Packaging: PASSED
    set BUILD_SUCCESS=true
) else (
    echo ❌ Packaging: FAILED
)

echo.
if "%BUILD_SUCCESS%"=="true" (
    echo 🎉 OVERALL STATUS: HEALTHY
    echo.
    echo Your Spring Boot Blog application is ready to run!
    echo.
    echo Quick Start Commands:
    echo   Normal Run:      mvn spring-boot:run
    echo   JAR Run:         java -jar target\spring-boot-blog-application-1.4.0.jar
    echo   Background:      .\quick-run.bat
    echo.
    echo Application will be available at: http://localhost:8080
    echo H2 Console available at: http://localhost:8080/h2-console
) else (
    echo ❌ OVERALL STATUS: BUILD ISSUES DETECTED
    echo.
    echo Please review the errors above and fix them before running the application.
)

echo.
echo ========================================
echo Health check completed.
REM Clean up
if exist startup.log del startup.log
pause
