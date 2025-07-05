@echo off
echo Starting Spring Boot Blog Application in background...
echo.

REM Build the application if not already built
if not exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo Building application first...
    mvn clean package -DskipTests
)

REM Start the application in background
echo Starting application on http://localhost:8080
echo.
start /B java -jar target\spring-boot-blog-application-1.4.0.jar

echo Application started in background!
echo.
echo Access the application at: http://localhost:8080
echo H2 Console available at: http://localhost:8080/h2-console
echo.
echo To stop the application, close the Java process from Task Manager
echo or press Ctrl+C if running in foreground
echo.
pause
