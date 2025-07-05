@echo off
echo =======================================
echo  Spring Boot Blog Application
echo =======================================
echo.

echo [1/4] Checking prerequisites...
java -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java not found! Please install Java 17 or higher.
    pause
    exit /b 1
)
echo Java: OK

mvn -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Maven not found! Please install Maven 3.6+
    pause
    exit /b 1
)
echo Maven: OK

echo.
echo [2/4] Creating uploads directory...
if not exist "uploads" mkdir uploads
echo Uploads directory: OK

echo.
echo [3/4] Building application...
mvn clean package -DskipTests
if errorlevel 1 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)
echo Build: OK

echo.
echo [4/4] Starting application...
echo =======================================
echo  APPLICATION STARTING
echo =======================================
echo.
echo Access URLs:
echo - Home Page: http://localhost:8080
echo - H2 Console: http://localhost:8080/h2-console
echo.
echo Default Login Credentials:
echo - Admin: admin@example.com / password
echo - Editor: editor@example.com / password
echo - User: user@example.com / password
echo.
echo Press Ctrl+C to stop the application
echo =======================================

mvn spring-boot:run

echo.
echo Application stopped.
pause
