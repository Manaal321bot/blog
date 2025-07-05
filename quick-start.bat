@echo off
echo Spring Blog Project - Quick Start
echo ==================================

echo.
echo [1/4] Cleaning previous builds...
call mvn clean

echo.
echo [2/4] Compiling project...
call mvn compile

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Compilation failed! Check the errors above.
    echo.
    echo Common fixes:
    echo - Ensure Java 17+ is installed: java -version
    echo - Check Maven is working: mvn -version
    echo - Try: mvn clean install -DskipTests
    echo.
    pause
    exit /b 1
)

echo.
echo [3/4] Running tests...
call mvn test -q

echo.
echo [4/4] Starting Spring Boot application...
echo.
echo ✅ Application will start at: http://localhost:8080
echo ✅ Login page: http://localhost:8080/login
echo ✅ H2 Console: http://localhost:8080/h2-console
echo.
echo Test accounts:
echo - User: user.user@domain.com / password
echo - Editor: editor.editor@domain.com / password
echo - Admin: admin.admin@domain.com / password
echo.
echo Press Ctrl+C to stop the application
echo.

call mvn spring-boot:run
