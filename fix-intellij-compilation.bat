@echo off
echo IntelliJ IDEA Compilation Fix Script
echo =====================================

echo.
echo [Step 1/6] Setting up Maven memory options...
set MAVEN_OPTS=-Xmx2048m -Xms512m -XX:MaxPermSize=512m
echo MAVEN_OPTS set to: %MAVEN_OPTS%

echo.
echo [Step 2/6] Cleaning target directory...
if exist target (
    echo Deleting target directory...
    rmdir /s /q target
) else (
    echo Target directory not found, skipping...
)

echo.
echo [Step 3/6] Cleaning IntelliJ cache files...
if exist .idea\compiler.xml (
    del /q .idea\compiler.xml
    echo Deleted compiler.xml
)
if exist .idea\modules.xml (
    echo Found modules.xml - keeping it
) else (
    echo modules.xml not found
)

echo.
echo [Step 4/6] Running Maven clean...
call mvn clean -q
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Maven clean failed!
    pause
    exit /b 1
)

echo.
echo [Step 5/6] Compiling with forked JVM...
call mvn compile -Dmaven.compiler.fork=true -Dmaven.compiler.maxmem=1024m
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Compilation failed!
    echo.
    echo Troubleshooting steps:
    echo 1. Check if Java 17+ is installed: java -version
    echo 2. Check if Maven is working: mvn -version
    echo 3. Close IntelliJ and try again
    echo 4. Run: mvn dependency:purge-local-repository
    echo.
    pause
    exit /b 1
) else (
    echo ✅ Compilation successful!
)

echo.
echo [Step 6/6] Verification...
if exist target\classes\com\example\springbootblogapplication\SpringBootBlogApplication.class (
    echo ✅ Main application class found
) else (
    echo ❌ Main application class not found
)

echo.
echo ✅ Script completed successfully!
echo.
echo Next steps for IntelliJ:
echo 1. Open IntelliJ IDEA
echo 2. File → Invalidate Caches and Restart
echo 3. Right-click pom.xml → Maven → Reload project
echo 4. Build → Rebuild Project
echo 5. Use the "Spring Boot App" run configuration
echo.
echo The application should now compile properly in IntelliJ!
echo.
pause
