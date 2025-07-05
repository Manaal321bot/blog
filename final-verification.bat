@echo off
echo ========================================
echo SPRING BOOT BLOG - FINAL VERIFICATION
echo ========================================
echo.

echo [Step 1] Cleaning and compiling...
call mvn clean compile -q
if %ERRORLEVEL% neq 0 (
    echo ❌ COMPILATION FAILED
    pause
    exit /b 1
)
echo ✅ Compilation successful

echo.
echo [Step 2] Running tests...
call mvn test -q
if %ERRORLEVEL% neq 0 (
    echo ❌ TESTS FAILED
    pause
    exit /b 1
)
echo ✅ Tests passed

echo.
echo [Step 3] Building final JAR...
call mvn package -DskipTests -q
if %ERRORLEVEL% neq 0 (
    echo ❌ BUILD FAILED
    pause
    exit /b 1
)
echo ✅ JAR built successfully

echo.
echo [Step 4] Verifying JAR file...
if exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo ✅ JAR file verified
    for %%I in ("target\spring-boot-blog-application-1.4.0.jar") do echo    Size: %%~zI bytes
) else (
    echo ❌ JAR file not found
    pause
    exit /b 1
)

echo.
echo ========================================
echo 🎉 ALL VERIFICATIONS PASSED!
echo ========================================
echo.
echo ✅ Fixed Issues:
echo   • Post creation forbidden error (CSRF tokens added)
echo   • Home page internal error (service methods fixed)
echo   • User comments not viewable (enhanced comment system)
echo   • User search not working (complete implementation)
echo.
echo ✅ New Features Added:
echo   • Real-time AJAX like system
echo   • Comprehensive user search
echo   • Enhanced CSRF protection
echo   • Responsive UI improvements
echo.
echo 🚀 Ready to run:
echo   java -jar target\spring-boot-blog-application-1.4.0.jar
echo.
echo 🌐 Access at: http://localhost:8080
echo 🔧 H2 Console: http://localhost:8080/h2-console
echo.

pause
