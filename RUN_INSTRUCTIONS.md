# Spring Boot Blog Application - Setup & Run Instructions

## 🎯 Features Implemented

### ✅ Core Blog Features
- **Modern UI Design**: Responsive, card-based layout with gradients and animations
- **Post Management**: Create, read, update, delete posts with rich text editor
- **User Authentication**: Login, registration, role-based access control
- **Image Upload**: Featured images for posts with preview functionality
- **Rich Text Editor**: Quill.js integration for content creation

### ✅ Interactive Features
- **Like System**: Real-time like/unlike functionality with AJAX
- **Comment System**: Add, view, delete comments with real-time updates
- **Share Functionality**: Social media sharing + copy to clipboard
- **Search Engine**: Full-text search across posts with suggestions
- **Tag System**: Categorize posts with searchable tags
- **Pagination**: Navigate through posts efficiently

### ✅ Advanced Features
- **User Profiles**: View user posts and statistics
- **Search Suggestions**: Auto-complete search functionality
- **Modern Templates**: Updated home, post creation, and post view pages
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Responsive Design**: Mobile-friendly across all devices

## 📋 Prerequisites

Before running the application, ensure you have:

1. **Java 17** or higher installed
2. **Maven 3.6+** installed
3. **MySQL 8.0+** running (or Docker for MySQL)
4. **Git** for version control

### Check Prerequisites

```powershell
# Check Java version
java -version

# Check Maven version
mvn -version

# Check MySQL status (if installed locally)
mysql --version
```

## 🛠️ Installation Steps

### 1. Navigate to Project Directory
```powershell
cd "C:\Users\Dell\Downloads\spring blog project\spring blog project"
```

### 2. Database Setup

#### Option A: Using Local MySQL
```sql
-- Login to MySQL as root
mysql -u root -p

-- Create database
CREATE DATABASE spring_blog_db;

-- Create user (optional)
CREATE USER 'blog_user'@'localhost' IDENTIFIED BY 'blog_password';
GRANT ALL PRIVILEGES ON spring_blog_db.* TO 'blog_user'@'localhost';
FLUSH PRIVILEGES;
```

#### Option B: Using Docker MySQL
```powershell
# Run MySQL in Docker
docker run --name mysql-blog -e MYSQL_ROOT_PASSWORD=rootpassword -e MYSQL_DATABASE=spring_blog_db -p 3306:3306 -d mysql:8.0

# Wait for MySQL to start (about 30 seconds)
```

### 3. Configure Database Connection

Update `src/main/resources/application.properties`:

```properties
# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/spring_blog_db
spring.datasource.username=root
spring.datasource.password=rootpassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA/Hibernate Configuration
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

# Flyway Configuration
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration

# File Upload Configuration
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB

# Application Configuration
server.port=8080
logging.level.org.springframework.security=DEBUG
```

### 4. Build the Application

```powershell
# Clean and compile
mvn clean compile

# Run tests (optional)
mvn test

# Package the application
mvn clean package -DskipTests
```

## 🚀 Running the Application

### Method 1: Using Maven Spring Boot Plugin (Recommended)
```powershell
mvn spring-boot:run
```

### Method 2: Using JAR File
```powershell
# After building with mvn clean package
java -jar target/spring-boot-blog-application-1.4.0.jar
```

### Method 3: From IDE
- Open the project in IntelliJ IDEA or Eclipse
- Run the `SpringBootBlogApplication.java` main class

## 🌐 Accessing the Application

Once the application starts successfully:

- **Home Page**: http://localhost:8080
- **Login**: http://localhost:8080/login
- **Register**: http://localhost:8080/register
- **Admin Dashboard**: http://localhost:8080/dashboard (requires login)

### Default Users (Created by SeedData)

The application creates default users automatically:

1. **Admin User**
   - Email: admin@example.com
   - Password: password
   - Role: ADMIN

2. **Editor User**
   - Email: editor@example.com
   - Password: password
   - Role: EDITOR

3. **Regular User**
   - Email: user@example.com
   - Password: password
   - Role: USER

## 📱 Using the Application

### 1. First-Time Setup
1. Go to http://localhost:8080
2. Click "Register" to create a new account, or
3. Login with default credentials above

### 2. Creating Posts
1. Click "Write Post" in the navigation
2. Fill in the title, excerpt (optional), and content using the rich text editor
3. Upload a featured image
4. Add tags (comma-separated)
5. Click "Publish Post"

### 3. Interacting with Posts
- **Like posts**: Click the heart icon
- **Comment**: Click on a post and scroll to comments section
- **Share**: Use the share button for social media or copy link
- **Search**: Use the search bar in the navigation

### 4. Search Functionality
- Type in the search bar and press Enter
- Search works across post titles and content
- Use tags to filter posts by category

## 🔧 Troubleshooting

### Common Issues

#### 1. Database Connection Error
```
Error: Could not connect to database
```
**Solution:**
- Ensure MySQL is running
- Check database credentials in `application.properties`
- Verify database `spring_blog_db` exists

#### 2. Port Already in Use
```
Error: Port 8080 is already in use
```
**Solution:**
```powershell
# Find process using port 8080
netstat -ano | findstr :8080

# Kill the process (replace PID with actual process ID)
taskkill /PID <PID> /F

# Or change port in application.properties
server.port=8081
```

#### 3. File Upload Issues
```
Error: Maximum upload size exceeded
```
**Solution:**
- Check file size limits in `application.properties`
- Ensure `uploads` directory exists and has write permissions

#### 4. Flyway Migration Errors
```
Error: Migration failed
```
**Solution:**
```powershell
# Reset database and restart application
DROP DATABASE spring_blog_db;
CREATE DATABASE spring_blog_db;
```

### 5. Template Not Found Errors
If you get template errors, ensure you're using the modern templates:
- Replace `post_new.html` with `post_new_modern.html`
- Replace `post.html` with `post_modern.html`
- Use the updated `home.html`

## 📁 Project Structure

```
spring-boot-blog-application/
├── src/main/java/com/example/springbootblogapplication/
│   ├── controllers/          # REST and Web Controllers
│   │   ├── ApiController.java      # Like/Comment APIs
│   │   ├── SearchController.java   # Search functionality
│   │   ├── ProfileController.java  # User profiles
│   │   └── ...
│   ├── models/               # Entity Classes
│   │   ├── Post.java              # Enhanced with likes, comments, tags
│   │   ├── Like.java              # Like system
│   │   ├── Comment.java           # Comment system
│   │   ├── Tag.java               # Tag system
│   │   └── ...
│   ├── repositories/         # Data Access Layer
│   ├── services/            # Business Logic
│   │   ├── LikeService.java       # Like operations
│   │   ├── CommentService.java    # Comment operations
│   │   ├── TagService.java        # Tag operations
│   │   ├── SearchService.java     # Search functionality
│   │   └── ...
│   └── SpringBootBlogApplication.java
├── src/main/resources/
│   ├── templates/           # Thymeleaf Templates
│   │   ├── home.html             # Modern home page
│   │   ├── post_modern.html      # Enhanced post view
│   │   ├── post_new_modern.html  # Rich post editor
│   │   ├── search_results.html   # Search results
│   │   └── ...
│   ├── static/             # Static Assets
│   ├── db/migration/       # Database Migrations
│   │   ├── V1__initial_migration.sql
│   │   ├── V2__add_imageFilePathToPost.sql
│   │   └── V3__add_likes_and_comments.sql
│   └── application.properties
└── uploads/                # Uploaded Images
```

## 🔄 Database Migrations

The application uses Flyway for database versioning:

- **V1**: Initial tables (posts, accounts, authorities)
- **V2**: Add image file path to posts
- **V3**: Add likes, comments, tags tables

Migrations run automatically on application startup.

## 🚀 Development Tips

### Adding New Features
1. Create model classes in `models/` package
2. Add repository interfaces in `repositories/`
3. Implement business logic in `services/`
4. Create controllers in `controllers/`
5. Add templates in `src/main/resources/templates/`
6. Create migration scripts in `src/main/resources/db/migration/`

### Testing the APIs
Use tools like Postman or curl to test the REST APIs:

```bash
# Like a post
curl -X POST http://localhost:8080/api/posts/1/like \
  -H "Content-Type: application/json"

# Add a comment
curl -X POST http://localhost:8080/api/posts/1/comments \
  -H "Content-Type: application/json" \
  -d '{"content": "Great post!"}'

# Search suggestions
curl "http://localhost:8080/api/search/suggestions?q=java"
```

## 📞 Support

If you encounter any issues:

1. Check the console logs for error messages
2. Verify database connectivity
3. Ensure all dependencies are properly installed
4. Check the troubleshooting section above

For development questions, refer to the Spring Boot and Thymeleaf documentation.

---

## 🎉 Enjoy Your Modern Blog Application!

You now have a fully-featured, modern blog application with:
- ✅ Rich content creation
- ✅ Interactive features (likes, comments, sharing)
- ✅ Search functionality
- ✅ User profiles
- ✅ Modern, responsive UI
- ✅ Robust error handling

Happy blogging! 🚀
