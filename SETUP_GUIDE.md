# Spring Blog Project - Enhanced Features Setup Guide

## Overview
This enhanced Spring Boot blog application now includes the following new features:

1. **Separate Interface for Adding Posts** - `addPost.html`
2. **Modularized Features** - Enhanced services and controllers
3. **Enhanced Dashboard** - Multiple posts with like, comment, and share functionality
4. **Editor Role and Interface** - Role-based access control with editor management panel
5. **Fixed Search Functionality** - Improved search with proper error handling

## New Features Implemented

### 1. Enhanced Database Configuration
- **H2 Database**: Configured for easy testing (no Docker required)
- **MySQL Support**: Available via Docker compose for production
- **Database URL**: `jdbc:h2:mem:testdb` (accessible at `/h2-console`)

### 2. User Roles and Authentication
- **ROLE_USER**: Basic user access
- **ROLE_EDITOR**: Can create and manage posts
- **ROLE_ADMIN**: Full administrative access

### 3. Default User Accounts
- **Regular User**: `user.user@domain.com` / `password`
- **Editor**: `editor.editor@domain.com` / `password` 
- **Admin**: `admin.admin@domain.com` / `password`

### 4. New Pages and Features

#### Dashboard (`/dashboard`)
- Enhanced UI with post cards
- Search functionality
- Like, comment, and share buttons
- Quick action buttons
- Statistics sidebar
- Role-based navigation

#### Add Post Interface (`/posts/add`)
- Dedicated post creation page
- Image upload with preview
- Rich content editor
- Role-based access (Editor/Admin only)

#### Editor Panel (`/editor`)
- Post management interface
- Bulk actions (publish, unpublish, delete)
- Statistics overview
- Content guidelines
- Quick actions panel

### 5. Enhanced Search Functionality
- Search by title or content
- Case-insensitive search
- Integration with dashboard
- Error handling for empty results

## Setup Instructions

### Option 1: Quick Start (H2 Database)
1. Navigate to the project directory:
   ```bash
   cd "C:\Users\Dell\Downloads\spring blog project\spring blog project"
   ```

2. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```
   Or on Windows:
   ```cmd
   mvnw.cmd spring-boot:run
   ```

3. Access the application:
   - **Main Site**: http://localhost:8080
   - **H2 Console**: http://localhost:8080/h2-console
   - **Dashboard**: http://localhost:8080/dashboard (requires login)
   - **Editor Panel**: http://localhost:8080/editor (requires Editor/Admin role)

### Option 2: Production Setup (MySQL)
1. Install Docker and Docker Compose

2. Create `.env` file from `.env.local`:
   ```bash
   cp .env.local .env
   ```

3. Update `.env` with your database credentials:
   ```
   MYSQL_DATABASE=spring_blog_db
   MYSQL_USER=blog_user
   MYSQL_PASSWORD=your_password
   MYSQL_ROOT_PASSWORD=root_password
   ```

4. Update `application.properties` to use MySQL:
   ```properties
   spring.flyway.enabled=true
   spring.jpa.hibernate.ddl-auto=update
   spring.datasource.url=jdbc:mysql://localhost:3306/${MYSQL_DATABASE}
   spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
   spring.datasource.username=${MYSQL_USER}
   spring.datasource.password=${MYSQL_PASSWORD}
   ```

5. Start the database:
   ```bash
   docker compose up -d
   ```

6. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```

## Using the Enhanced Features

### 1. Dashboard
- **Login** with any of the provided accounts
- **Navigate** to `/dashboard` or click "Dashboard" in navigation
- **Search** for posts using the search bar
- **Interact** with posts using like, comment, and share buttons
- **Filter** posts by criteria (All, Recent, Popular)

### 2. Creating Posts
- **Login** as Editor or Admin
- **Navigate** to `/posts/add` or click "Add Post"
- **Fill** in title, content, and optionally upload an image
- **Submit** to create the post

### 3. Editor Panel
- **Login** as Editor or Admin
- **Navigate** to `/editor` or click "Editor Panel"
- **Manage** all posts from the management table
- **Use bulk actions** to manage multiple posts
- **View statistics** and recent activity

### 4. Search Functionality
- **Use the search bar** in the dashboard
- **Search** by post title or content
- **Results** are filtered in real-time
- **Clear search** by submitting empty query

## Technical Improvements

### 1. Modularized Services
- **PostService**: Enhanced with search, pagination, and CRUD operations
- **AccountService**: Role-based user management
- **FileService**: Image upload and management

### 2. Enhanced Controllers
- **DashboardController**: Handles dashboard and search
- **EditorController**: Role-based editor interface
- **PostController**: Enhanced with new routes

### 3. Repository Enhancements
- **Custom queries** for search functionality
- **Date-based filtering** methods
- **Author-specific** post retrieval
- **Optimized queries** for performance

### 4. Security Improvements
- **Role-based access control** using `@PreAuthorize`
- **Method-level security** for sensitive operations
- **User authentication** for all protected routes

## API Endpoints

### Public Endpoints
- `GET /` - Home page with all posts
- `GET /posts/{id}` - View individual post
- `GET /login` - Login page
- `GET /register` - Registration page

### Authenticated Endpoints
- `GET /dashboard` - User dashboard with search
- `GET /posts/new` - Create new post (basic interface)
- `POST /posts/new` - Submit new post

### Editor/Admin Only Endpoints
- `GET /posts/add` - Enhanced post creation interface
- `GET /editor` - Editor management panel
- `GET /posts/{id}/edit` - Edit post
- `POST /posts/{id}` - Update post

### Admin Only Endpoints
- `GET /posts/{id}/delete` - Delete post

## Database Schema

The application uses the following main entities:

### Account
- **id**: Primary key
- **email**: Unique identifier
- **firstName**, **lastName**: User names
- **password**: Encrypted password
- **authorities**: User roles

### Post
- **id**: Primary key
- **title**: Post title
- **body**: Post content
- **imageFilePath**: Optional featured image
- **createdAt**, **updatedAt**: Timestamps
- **account**: Author reference

### Authority
- **name**: Role name (ROLE_USER, ROLE_EDITOR, ROLE_ADMIN)

## Troubleshooting

### Common Issues
1. **Port 8080 already in use**: Change port in `application.properties`
2. **Database connection issues**: Check H2 console at `/h2-console`
3. **File upload issues**: Check uploads directory permissions
4. **Login issues**: Use provided default accounts

### Development Tips
1. **H2 Console**: Access at `/h2-console` with JDBC URL `jdbc:h2:mem:testdb`
2. **Profile-based config**: Use Spring profiles for different environments
3. **Logging**: Enable debug logging for troubleshooting
4. **Hot reload**: Use Spring Boot DevTools for faster development

## Next Steps

To further enhance the application, consider:

1. **Comments System**: Implement persistent comments with database storage
2. **Categories/Tags**: Add post categorization
3. **Email Notifications**: Notify on new posts/comments
4. **REST API**: Add JSON API endpoints
5. **Frontend Framework**: Integrate React/Vue.js
6. **File Management**: Advanced image handling and storage
7. **SEO Optimization**: Add meta tags and sitemap
8. **Performance**: Implement caching and pagination

## Support

For issues or questions about the enhanced features:
1. Check the console logs for errors
2. Verify user roles and permissions
3. Ensure proper database connectivity
4. Review the setup instructions

The application now provides a comprehensive blogging platform with role-based access control, enhanced search functionality, and modern UI components.
