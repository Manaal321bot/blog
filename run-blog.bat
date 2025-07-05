@echo off
echo =======================================
echo  Spring Boot Blog Application Launcher
echo =======================================
echo.

echo Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java not found! Please install Java 17 or higher.
    pause
    exit /b 1
)
echo Java: OK

echo Checking Maven installation...
mvn -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Maven not found! Please install Maven 3.6+
    pause
    exit /b 1
)
echo Maven: OK

echo.
echo Building application...
mvn clean compile package -DskipTests
if errorlevel 1 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo.
echo =======================================
echo  Application Information
echo =======================================
echo Home Page: http://localhost:8080
echo Admin Login: admin@example.com / password
echo Editor Login: editor@example.com / password
echo User Login: user@example.com / password
echo.
echo Starting application...
echo Press Ctrl+C to stop
echo =======================================

mvn spring-boot:run

echo.
echo Application stopped.
pause
