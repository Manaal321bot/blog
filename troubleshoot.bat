@echo off
title Spring Boot Blog - Troubleshooting
color 0E

echo ========================================
echo    SPRING BOOT BLOG - TROUBLESHOOTING
echo ========================================
echo.

echo 🔍 Diagnosing potential issues...
echo.

echo [Check 1] Java Installation...
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Java not found or not in PATH
    echo    Solution: Install Java 17+ and add to PATH
    goto :end
) else (
    echo ✅ Java is available
    java -version
)

echo.
echo [Check 2] Maven Installation...
mvn -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Maven not found or not in PATH
    echo    Solution: Install Maven and add to PATH
    goto :end
) else (
    echo ✅ Maven is available
)

echo.
echo [Check 3] Project Structure...
if exist "pom.xml" (
    echo ✅ pom.xml found
) else (
    echo ❌ pom.xml not found
    echo    Solution: Navigate to project root directory
    goto :end
)

if exist "src\main\java" (
    echo ✅ Source directory found
) else (
    echo ❌ Source directory missing
    goto :end
)

echo.
echo [Check 4] Compilation Status...
mvn compile -q
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Compilation failed
    echo    Running detailed compilation to show errors:
    echo.
    mvn compile
    goto :end
) else (
    echo ✅ Compilation successful
)

echo.
echo [Check 5] Dependencies...
mvn dependency:resolve -q >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Dependencies resolution failed
    echo    Solution: Run 'mvn clean install' to download dependencies
    goto :end
) else (
    echo ✅ All dependencies resolved
)

echo.
echo [Check 6] Port Availability...
netstat -ano | findstr :8080 >nul
if %ERRORLEVEL% EQU 0 (
    echo ⚠️  Port 8080 is in use
    echo    Processes using port 8080:
    netstat -ano | findstr :8080
    echo.
    echo    Solution: Kill the process or use a different port
) else (
    echo ✅ Port 8080 is available
)

echo.
echo [Check 7] JAR File...
if exist "target\spring-boot-blog-application-1.4.0.jar" (
    echo ✅ JAR file exists
    for %%I in ("target\spring-boot-blog-application-1.4.0.jar") do echo    Size: %%~zI bytes
) else (
    echo ❌ JAR file not found
    echo    Solution: Run 'mvn package' to build JAR
)

echo.
echo [Check 8] Memory Requirements...
systeminfo | findstr "Total Physical Memory" 2>nul
echo    Recommended: At least 2GB RAM available
echo    JVM will use: 1GB max (-Xmx1024m)

echo.
echo ========================================
echo           COMMON SOLUTIONS
echo ========================================
echo.
echo 🛠️  If you're experiencing issues:
echo.
echo 1. Clean build:
echo    mvn clean package -DskipTests
echo.
echo 2. Force kill processes:
echo    taskkill /F /IM java.exe
echo.
echo 3. Free port 8080:
echo    netstat -ano ^| findstr :8080
echo    taskkill /F /PID [PID_NUMBER]
echo.
echo 4. Use different port:
echo    java -jar target\spring-boot-blog-application-1.4.0.jar --server.port=8081
echo.
echo 5. Reset everything:
echo    mvn clean
echo    mvn compile
echo    mvn package
echo.

:end
echo.
echo Press any key to exit...
pause >nul
