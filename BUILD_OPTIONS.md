# Spring Boot Blog - Build & Run Options

This document explains different ways to build and run the Spring Boot Blog application without blocking your terminal.

## Quick Start Options

### 1. Quick Run (Recommended)
```bash
./quick-run.bat
```
- Automatically builds if needed
- Starts application in separate window
- Keeps your terminal free for other commands

### 2. Build Only (No Running)
```bash
./build-only.bat
```
- Compiles and packages the application
- Creates JAR file without running it
- Perfect for CI/CD or testing compilation

### 3. Build Verification
```bash
./verify-build.bat
```
- Comprehensive build testing
- Runs compilation, tests, and packaging
- Verifies all build artifacts

### 4. Background Execution
```bash
./run-background.bat
```
- Starts application in background
- Terminal remains available
- Application runs silently

## Maven Commands (Non-blocking)

### Compile Only
```bash
mvn clean compile -Pfast-compile
```

### Package Without Running
```bash
mvn package -DskipTests -Pbuild-only
```

### Quick Build (Skip Tests)
```bash
mvn clean package -DskipTests
```

## Running the Application

### Option 1: Using JAR File (Recommended)
```bash
java -jar target/spring-boot-blog-application-1.4.0.jar
```

### Option 2: Using Maven (Will Block Terminal)
```bash
mvn spring-boot:run
```

### Option 3: Using Quick Run Script
```bash
./quick-run.bat
```

## Application Access

Once running, access the application at:
- **Web Interface**: http://localhost:8080
- **H2 Database Console**: http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:blogdb`
  - Username: `sa`
  - Password: `password`

## Troubleshooting

### If Build Gets Stuck
1. Stop the process with `Ctrl+C`
2. Use `./build-only.bat` instead
3. Run with fast-compile profile: `mvn clean compile -Pfast-compile`

### If Application Won't Start
1. Check if port 8080 is available
2. Verify JAR file exists in `target/` directory
3. Check Java version: `java -version` (requires Java 17+)

### Memory Issues
The application is configured with optimized memory settings:
- Compile: Standard heap sizes
- Runtime: 2GB max, 512MB initial

## Development Workflow

1. **First Time Setup**:
   ```bash
   ./verify-build.bat
   ```

2. **Daily Development**:
   ```bash
   ./quick-run.bat
   ```

3. **Testing Changes**:
   ```bash
   mvn clean compile -Pfast-compile
   ./quick-run.bat
   ```

4. **Production Build**:
   ```bash
   mvn clean package -DskipTests
   ```

## Build Profiles

- `fast-compile`: Skip tests, fast compilation
- `build-only`: Package without running Spring Boot plugin
- Default: Normal build with all features

Choose the option that best fits your development workflow!
