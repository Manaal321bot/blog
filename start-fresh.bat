@echo off
title Spring Boot Blog Application
echo ========================================
echo     SPRING BOOT BLOG - FRESH START
echo ========================================
echo.

echo 🚀 Starting Spring Boot Blog Application...
echo.
echo ⚙️  Application Features:
echo   • Post Creation and Management
echo   • User Authentication and Authorization  
echo   • Like and Comment System
echo   • User Search and Discovery
echo   • CSRF Protection
echo   • Responsive Design
echo.
echo 🌐 Access Points:
echo   • Main Application: http://localhost:8080
echo   • H2 Database Console: http://localhost:8080/h2-console
echo.
echo 🔧 Database Credentials:
echo   • JDBC URL: jdbc:h2:mem:blogdb
echo   • Username: sa
echo   • Password: password
echo.
echo ⏳ Starting server... Please wait...
echo.

REM Start the application
java -jar target\spring-boot-blog-application-1.4.0.jar --server.port=8080

echo.
echo 🛑 Application stopped.
pause
