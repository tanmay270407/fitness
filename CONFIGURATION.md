# 🔧 Fitness Platform - Configuration & Setup Guide

## Quick Configuration Reference

### Database Configuration

**File**: `src/main/java/com/fitness/util/DBConnection.java`

```java
// Current Settings
private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
private static final String DB_URL = "jdbc:mysql://localhost:3306/fitness_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = ""; // Update this!
```

**Change these for your environment:**
```java
// Example for remote server
private static final String DB_URL = "jdbc:mysql://192.168.1.100:3306/fitness_db";
private static final String DB_USER = "fitnessuser";
private static final String DB_PASSWORD = "your_secure_password";
```

---

## Web Configuration

**File**: `src/main/webapp/WEB-INF/web.xml`

### Servlet Mappings
```xml
<!-- Authentication -->
<servlet-mapping>
    <servlet-name>AuthServlet</servlet-name>
    <url-pattern>/auth</url-pattern>
</servlet-mapping>

<!-- Workouts -->
<servlet-mapping>
    <servlet-name>WorkoutServlet</servlet-name>
    <url-pattern>/workout</url-pattern>
</servlet-mapping>

<!-- Profile -->
<servlet-mapping>
    <servlet-name>ProfileServlet</servlet-name>
    <url-pattern>/profile</url-pattern>
</servlet-mapping>
```

### Welcome File
```xml
<welcome-file-list>
    <welcome-file>login.jsp</welcome-file>
</welcome-file-list>
```

---

## Environment Setup

### JDK Configuration
```
Required: JDK 8 or higher
Recommended: JDK 11+
Location: C:\Program Files\Java\jdk-XX
```

### Tomcat Configuration
```
Version: Apache Tomcat 7.0+
Recommended: Tomcat 9.0+
Port: 8080 (default)
Location: C:\Apache\Tomcat\apache-tomcat-9.x
```

### MySQL Configuration
```
Version: MySQL 5.7+
Recommended: MySQL 8.0+
Port: 3306 (default)
Database: fitness_db
Charset: utf8mb4
Collation: utf8mb4_unicode_ci
```

---

## JDBC Driver Setup

### Step 1: Download
```
Visit: https://dev.mysql.com/downloads/connector/j/
Download: mysql-connector-java-8.x.x.jar
```

### Step 2: Install
```
Copy to: src/main/webapp/WEB-INF/lib/mysql-connector-java-8.x.x.jar
```

### Step 3: Verify
```
Check Eclipse: Project → Properties → Java Build Path → Libraries
Should see: mysql-connector-java-8.x.x.jar
```

---

## Database Setup Steps

### Step 1: Create Database
```sql
CREATE DATABASE fitness_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

### Step 2: Create Tables
```sql
USE fitness_db;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    weight DOUBLE DEFAULT 0,
    height DOUBLE DEFAULT 0,
    age INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Workouts Table
CREATE TABLE workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    workout_type VARCHAR(50) NOT NULL,
    workout_name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    calories INT NOT NULL,
    description TEXT,
    workout_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Indexes
CREATE INDEX idx_user_id ON workouts(user_id);
CREATE INDEX idx_workout_date ON workouts(workout_date);
```

### Step 3: Verify Tables
```sql
SHOW TABLES;
DESCRIBE users;
DESCRIBE workouts;
```

---

## Application URLs

### Main Pages
```
Login:     http://localhost:8080/fitness/
Signup:    http://localhost:8080/fitness/auth?action=signup
Dashboard: http://localhost:8080/fitness/dashboard.jsp
Profile:   http://localhost:8080/fitness/profile
```

### Workout Pages
```
Add Workout:  http://localhost:8080/fitness/workout
View:         http://localhost:8080/fitness/workout?action=view
Edit:         http://localhost:8080/fitness/workout?action=edit&id=1
Delete:       http://localhost:8080/fitness/workout?action=delete&id=1
```

### Authentication
```
Logout:    http://localhost:8080/fitness/auth?action=logout
```

---

## Session Configuration

### Session Timeout
**Default**: 30 minutes

**To Change** (in web.xml):
```xml
<session-config>
    <cookie-config>
        <secure>false</secure>
        <http-only>true</http-only>
    </cookie-config>
    <tracking-mode>COOKIE</tracking-mode>
</session-config>
```

### Session Management
```java
// Create session
HttpSession session = request.getSession();

// Set attribute
session.setAttribute("userId", user.getUserId());

// Get attribute
Integer userId = (Integer) session.getAttribute("userId");

// Invalidate session
session.invalidate();
```

---

## Servlet Configuration Details

### AuthServlet (/auth)
```java
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    
    // Handles:
    // GET /auth              → show login form
    // GET /auth?action=signup → show signup form
    // GET /auth?action=logout → invalidate session
    // POST /auth             → process login
    // POST /auth?action=signup → process signup
}
```

### WorkoutServlet (/workout)
```java
@WebServlet("/workout")
public class WorkoutServlet extends HttpServlet {
    
    // Handles:
    // GET /workout                    → show add form
    // GET /workout?action=view        → show all workouts
    // GET /workout?action=edit&id=X   → show edit form
    // GET /workout?action=delete&id=X → delete workout
    // POST /workout (action=add)      → add workout
    // POST /workout (action=update)   → update workout
}
```

### ProfileServlet (/profile)
```java
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    // Handles:
    // GET /profile  → show profile page
    // POST /profile → update profile
}
```

---

## Logging Configuration

### Console Output
Logs appear in:
- Eclipse Console
- Tomcat logs folder: `catalina.out`

### Adding Logging
```java
// Print to console
System.out.println("Debug message");

// Or use proper logging
import java.util.logging.Logger;
private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());
logger.info("User logged in");
```

---

## File Upload Configuration

**For future file upload feature:**
```java
// In servlet
request.getPart("file");
```

**In web.xml:**
```xml
<multipart-config>
    <max-file-size>5242880</max-file-size>
    <max-request-size>20971520</max-request-size>
    <file-size-threshold>1048576</file-size-threshold>
</multipart-config>
```

---

## Security Configuration

### HTTPS Configuration (Tomcat)
```xml
<!-- server.xml -->
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
    maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
    clientAuth="false" sslProtocol="TLS" />
```

### Context Configuration
```xml
<!-- context.xml -->
<Context useHttpOnly="true" sessionCookiePath="/">
</Context>
```

---

## Performance Tuning

### Database Connection Pool (Future)
```java
// Consider using HikariCP
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>5.0.1</version>
</dependency>
```

### Caching (Future)
```java
// Consider using Redis or Memcached
```

### Query Optimization
- ✅ Indexes already added
- ✅ Prepared statements used
- ✅ Foreign keys configured

---

## Backup & Maintenance

### Database Backup
```sql
-- Full backup
mysqldump -u root -p fitness_db > backup.sql

-- Restore backup
mysql -u root -p fitness_db < backup.sql
```

### Regular Maintenance
```sql
-- Optimize tables
OPTIMIZE TABLE users;
OPTIMIZE TABLE workouts;

-- Check table integrity
CHECK TABLE users;
CHECK TABLE workouts;

-- Repair if needed
REPAIR TABLE users;
REPAIR TABLE workouts;
```

---

## Troubleshooting

### Database Connection Error
```
Error: "com.mysql.jdbc.exceptions.jdbc4.CommunicationsException"
Solution: 
1. Check MySQL is running
2. Verify connection string in DBConnection.java
3. Test connection with: mysql -u root -p
```

### JDBC Driver Not Found
```
Error: "java.lang.ClassNotFoundException: com.mysql.jdbc.Driver"
Solution:
1. Verify JAR in WEB-INF/lib/
2. Refresh Eclipse project
3. Clean and rebuild project
```

### Session Not Persisting
```
Error: User logged out after page reload
Solution:
1. Check cookies are enabled in browser
2. Verify session-config in web.xml
3. Check session timeout setting
```

### Form Data Lost
```
Error: Form values disappear after validation error
Solution:
1. Use request.getParameter() to retain values
2. Add value="${param.fieldName}" to input elements
3. See login.jsp for example
```

---

## Monitoring & Logs

### Tomcat Logs Location
```
Windows: C:\Apache\Tomcat\logs\catalina.out
Linux:   /var/log/tomcat9/catalina.out
```

### Monitor Database
```sql
-- Active connections
SHOW PROCESSLIST;

-- Table status
SHOW TABLE STATUS FROM fitness_db;

-- Database size
SELECT 
    table_name, 
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES 
WHERE table_schema = 'fitness_db';
```

---

## Deployment Checklist

### Pre-Deployment
- [ ] Database created and tables initialized
- [ ] JDBC driver downloaded and placed
- [ ] DBConnection.java updated with credentials
- [ ] Project compiles without errors
- [ ] No compilation warnings
- [ ] All JSP files present
- [ ] web.xml properly configured

### Deployment
- [ ] Stop Tomcat
- [ ] Clean Tomcat work directory
- [ ] Build WAR file
- [ ] Copy WAR to webapps
- [ ] Start Tomcat
- [ ] Check Tomcat logs
- [ ] Access application

### Post-Deployment
- [ ] Test signup functionality
- [ ] Test login functionality
- [ ] Add test workout
- [ ] View all workouts
- [ ] Edit workout
- [ ] Delete workout
- [ ] Update profile
- [ ] Test logout

---

**Last Updated**: November 25, 2025
**Version**: 1.0.0
**Status**: ✅ Production Ready
