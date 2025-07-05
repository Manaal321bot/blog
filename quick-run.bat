@echo off
echo Starting Spring Boot Blog Application...
echo.

REM Check if JAR exists, build if not
if not exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo Building application first...
    mvn package -DskipTests
    echo.
)

echo Starting application in new window...
echo Application will open at: http://localhost:8080
echo.

REM Start in new command window so current terminal remains free
start "Spring Boot Blog" cmd /k "java -jar target\spring-boot-blog-application-1.4.0.jar"

echo.
echo Application started in separate window!
echo Your terminal is now free for other commands.
echo.
echo To access the application:
echo - Web Interface: http://localhost:8080
echo - H2 Database Console: http://localhost:8080/h2-console
echo.
echo To stop the application, close the Spring Boot Blog window.
echo.
