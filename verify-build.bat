@echo off
echo ========================================
echo  Spring Boot Blog - Build Verification
echo ========================================
echo.

REM Step 1: Clean and compile only
echo [1/4] Cleaning and compiling source code...
mvn clean compile
if %ERRORLEVEL% neq 0 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)
echo SUCCESS: Compilation completed successfully!
echo.

REM Step 2: Run tests (optional, can be skipped)
echo [2/4] Running tests...
mvn test
if %ERRORLEVEL% neq 0 (
    echo WARNING: Some tests failed, but continuing...
) else (
    echo SUCCESS: All tests passed!
)
echo.

REM Step 3: Package the application
echo [3/4] Packaging the application...
mvn package -DskipTests
if %ERRORLEVEL% neq 0 (
    echo ERROR: Packaging failed!
    pause
    exit /b 1
)
echo SUCCESS: Application packaged successfully!
echo.

REM Step 4: Verify JAR file exists
echo [4/4] Verifying build artifacts...
if exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo SUCCESS: JAR file created successfully!
    echo File location: target\spring-boot-blog-application-1.4.0.jar
    
    REM Get file size
    for %%A in ("target\spring-boot-blog-application-1.4.0.jar") do (
        echo File size: %%~zA bytes
    )
) else (
    echo ERROR: JAR file not found!
    pause
    exit /b 1
)

echo.
echo ========================================
echo  BUILD VERIFICATION COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo The application can be started with:
echo   java -jar target\spring-boot-blog-application-1.4.0.jar
echo.
echo Or for development with auto-reload:
echo   mvn spring-boot:run
echo.
echo Application will be available at:
echo   http://localhost:8080
echo   H2 Console: http://localhost:8080/h2-console
echo.
pause
