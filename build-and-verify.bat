@echo off
echo ========================================
echo Spring Boot Blog Application - Build and Verification
echo ========================================
echo.

echo [Step 1] Cleaning previous builds...
call mvn clean
if %ERRORLEVEL% neq 0 (
    echo ERROR: Clean failed
    exit /b 1
)

echo.
echo [Step 2] Compiling sources...
call mvn compile
if %ERRORLEVEL% neq 0 (
    echo ERROR: Compilation failed
    exit /b 1
)

echo.
echo [Step 3] Running tests...
call mvn test
if %ERRORLEVEL% neq 0 (
    echo ERROR: Tests failed
    exit /b 1
)

echo.
echo [Step 4] Creating JAR package...
call mvn package -DskipTests
if %ERRORLEVEL% neq 0 (
    echo ERROR: Packaging failed
    exit /b 1
)

echo.
echo [Step 5] Verifying JAR file creation...
if exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo SUCCESS: JAR file created successfully
    dir "target\spring-boot-blog-application-1.4.0.jar"
) else (
    echo ERROR: JAR file was not created
    exit /b 1
)

echo.
echo ========================================
echo BUILD VERIFICATION COMPLETE - ALL TESTS PASSED!
echo ========================================
echo.
echo To run the application:
echo java -jar target\spring-boot-blog-application-1.4.0.jar
echo.
echo Or run with custom port:
echo java -jar target\spring-boot-blog-application-1.4.0.jar --server.port=8081
echo.
echo Application will be available at: http://localhost:8080 (or your custom port)
echo H2 Database console: http://localhost:8080/h2-console
echo.

pause
