@echo off
title Spring Boot Blog - Clean Startup
color 0A

echo ========================================
echo   SPRING BOOT BLOG - CLEAN STARTUP
echo ========================================
echo.

echo [Step 1] Cleaning up any running processes...
taskkill /F /IM java.exe >nul 2>&1
taskkill /F /IM javaw.exe >nul 2>&1
echo ✅ Process cleanup completed

echo.
echo [Step 2] Checking port availability...
netstat -ano | findstr :8080 >nul
if %ERRORLEVEL% EQU 0 (
    echo ⚠️  Port 8080 is in use. Attempting to free it...
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080') do (
        taskkill /F /PID %%a >nul 2>&1
    )
    timeout /t 2 /nobreak >nul
    echo ✅ Port 8080 freed
) else (
    echo ✅ Port 8080 is available
)

echo.
echo [Step 3] Verifying JAR file...
if exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo ✅ JAR file found and ready
) else (
    echo ❌ JAR file not found. Building...
    mvn package -DskipTests -q
    if %ERRORLEVEL% NEQ 0 (
        echo ❌ Build failed. Please check for errors.
        pause
        exit /b 1
    )
    echo ✅ JAR file built successfully
)

echo.
echo [Step 4] Setting up environment...
set JAVA_OPTS=-Xmx1024m -Xms512m -Dfile.encoding=UTF-8
set SERVER_PORT=8080
echo ✅ Environment configured

echo.
echo ========================================
echo      APPLICATION STARTING
echo ========================================
echo.
echo 🚀 Spring Boot Blog Application
echo.
echo 📍 Access Points:
echo   • Main App: http://localhost:8080
echo   • H2 Console: http://localhost:8080/h2-console
echo.
echo 🔧 Database Info:
echo   • URL: jdbc:h2:mem:blogdb
echo   • User: sa
echo   • Pass: password
echo.
echo 📋 Features Ready:
echo   • ✅ User Registration/Login
echo   • ✅ Post Creation (CSRF Fixed)
echo   • ✅ Like/Comment System
echo   • ✅ User Search
echo   • ✅ Responsive Design
echo.
echo 🔄 Starting server...
echo.

REM Start the application with proper JVM options
java %JAVA_OPTS% -jar target\spring-boot-blog-application-1.4.0.jar --server.port=%SERVER_PORT% --spring.profiles.active=default

echo.
echo ========================================
echo     APPLICATION STOPPED
echo ========================================
echo.
echo Press any key to exit...
pause >nul
