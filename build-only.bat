@echo off
echo Building Spring Boot Blog Application...
echo.

REM Clean and compile the application
mvn clean compile

REM Package the application into JAR
mvn package -DskipTests

echo.
echo Build completed successfully!
echo JAR file created at: target\spring-boot-blog-application-1.4.0.jar
echo.
echo To run the application:
echo   java -jar target\spring-boot-blog-application-1.4.0.jar
echo.
echo Or use: mvn spring-boot:run
echo.
pause
