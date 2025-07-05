# Spring Boot Blog Application - Quick Setup Script
# Run this script in PowerShell as Administrator

Write-Host "🚀 Spring Boot Blog Application Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "❌ Please run this script as Administrator" -ForegroundColor Red
    exit 1
}

# Check prerequisites
Write-Host "`n📋 Checking Prerequisites..." -ForegroundColor Yellow

# Check Java
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✅ Java: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Java not found. Please install Java 17 or higher." -ForegroundColor Red
    exit 1
}

# Check Maven
try {
    $mavenVersion = mvn -version | Select-String "Apache Maven"
    Write-Host "✅ Maven: $mavenVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Maven not found. Please install Maven 3.6+." -ForegroundColor Red
    exit 1
}

# Check Docker (optional)
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker: $dockerVersion" -ForegroundColor Green
    $dockerAvailable = $true
} catch {
    Write-Host "⚠️ Docker not found. You'll need to set up MySQL manually." -ForegroundColor Yellow
    $dockerAvailable = $false
}

# Database setup
Write-Host "`n🗄️ Database Setup..." -ForegroundColor Yellow

if ($dockerAvailable) {
    $useDocker = Read-Host "Use Docker for MySQL? (y/n)"
    if ($useDocker -eq "y" -or $useDocker -eq "Y") {
        Write-Host "Starting MySQL container..." -ForegroundColor Blue
        
        # Stop and remove existing container if exists
        docker stop mysql-blog 2>$null
        docker rm mysql-blog 2>$null
        
        # Start new MySQL container
        docker run --name mysql-blog -e MYSQL_ROOT_PASSWORD=rootpassword -e MYSQL_DATABASE=spring_blog_db -p 3306:3306 -d mysql:8.0
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ MySQL container started successfully" -ForegroundColor Green
            Write-Host "Waiting for MySQL to initialize (30 seconds)..." -ForegroundColor Blue
            Start-Sleep -Seconds 30
        } else {
            Write-Host "❌ Failed to start MySQL container" -ForegroundColor Red
            exit 1
        }
    }
} else {
    Write-Host "Please ensure MySQL is running and create database 'spring_blog_db'" -ForegroundColor Yellow
    $continue = Read-Host "Continue? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit 0
    }
}

# Build application
Write-Host "`n🔨 Building Application..." -ForegroundColor Yellow

Write-Host "Cleaning previous builds..." -ForegroundColor Blue
mvn clean

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Maven clean failed" -ForegroundColor Red
    exit 1
}

Write-Host "Compiling application..." -ForegroundColor Blue
mvn compile

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Maven compile failed" -ForegroundColor Red
    exit 1
}

Write-Host "Packaging application..." -ForegroundColor Blue
mvn package -DskipTests

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Maven package failed" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Application built successfully" -ForegroundColor Green

# Create uploads directory if it doesn't exist
if (-not (Test-Path "uploads")) {
    New-Item -ItemType Directory -Name "uploads"
    Write-Host "✅ Created uploads directory" -ForegroundColor Green
}

# Display application info
Write-Host "`n🌐 Application Information" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host "Home Page: http://localhost:8080" -ForegroundColor White
Write-Host "Admin Login: admin@example.com / password" -ForegroundColor White
Write-Host "Editor Login: editor@example.com / password" -ForegroundColor White
Write-Host "User Login: user@example.com / password" -ForegroundColor White

# Run application
Write-Host "`n🚀 Starting Application..." -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop the application" -ForegroundColor Yellow
Write-Host "=======================================" -ForegroundColor Cyan

try {
    mvn spring-boot:run
} catch {
    Write-Host "`n❌ Application failed to start" -ForegroundColor Red
    Write-Host "Check the error messages above for troubleshooting" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n👋 Application stopped. Goodbye!" -ForegroundColor Cyan
