# Fitness Platform - Quick Setup Guide

## ⚡ 5-Minute Setup

### 1. **MySQL Setup** (2 mins)
```sql
-- Open MySQL command line and run:
CREATE DATABASE fitness_db;
USE fitness_db;

-- Then execute the SQL from database_setup.sql file
```

### 2. **JDBC Driver** (1 min)
```
1. Download: https://dev.mysql.com/downloads/connector/j/
2. Extract the JAR file
3. Copy to: src/main/webapp/WEB-INF/lib/
```

### 3. **Update Connection** (1 min)
Edit: `src/main/java/com/fitness/util/DBConnection.java`
```java
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_mysql_password";
```

### 4. **Deploy** (1 min)
```
1. Right-click project in Eclipse
2. Select "Run on Server"
3. Choose Apache Tomcat
4. Access: http://localhost:8080/fitness/
```

---

## 📱 Page Navigation

```
http://localhost:8080/fitness/
    ↓
login.jsp (or signup.jsp)
    ↓
dashboard.jsp
    ├─ /workout → addWorkout.jsp
    ├─ /workout?action=view → viewWorkouts.jsp
    ├─ /workout?action=edit&id=X → editWorkout.jsp
    └─ /profile → profile.jsp
```

---

## 🧪 Test Login

First, add test user via MySQL:
```sql
INSERT INTO users (full_name, email, username, password, weight, height, age) 
VALUES ('Test User', 'test@fitness.com', 'testuser', 'test123', 70, 175, 25);
```

Then login with:
- **Username**: testuser
- **Password**: test123

---

## 📋 All Servlets & JSPs

### Servlets (Request Handlers)
| Servlet | URL | Purpose |
|---------|-----|---------|
| AuthServlet | /auth | Login/Signup |
| WorkoutServlet | /workout | Workout CRUD |
| ProfileServlet | /profile | User Profile |

### JSP Pages (Views)
| Page | Access | Purpose |
|------|--------|---------|
| login.jsp | / | Login form |
| signup.jsp | /auth?action=signup | Register |
| dashboard.jsp | /auth (after login) | Main dashboard |
| addWorkout.jsp | /workout | Add workout |
| viewWorkouts.jsp | /workout?action=view | List workouts |
| editWorkout.jsp | /workout?action=edit&id=X | Edit workout |
| profile.jsp | /profile | User profile |

---

## 🔧 Database Tables

### Users Table
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    weight DOUBLE,
    height DOUBLE,
    age INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Workouts Table
```sql
CREATE TABLE workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    workout_type VARCHAR(50),
    workout_name VARCHAR(100),
    duration INT,
    calories INT,
    description TEXT,
    workout_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

---

## 🐛 Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| `javax.servlet cannot be resolved` | Missing servlet API | Add Tomcat to buildpath |
| `mysql.jar not found` | Missing JDBC driver | Download & add to WEB-INF/lib |
| `Connection refused` | MySQL not running | Start MySQL service |
| `Table doesn't exist` | DB not initialized | Run database_setup.sql |
| Session not working | Browser cookies disabled | Enable cookies |

---

## 📊 What You Can Do

✅ Register new users
✅ Login with credentials  
✅ Add workouts with details
✅ View all your workouts
✅ Edit workout information
✅ Delete workouts
✅ Update personal profile
✅ Track total calories
✅ View workout statistics

---

## 🚀 Future Enhancements

1. **Security**
   - Password hashing (BCrypt)
   - CSRF tokens
   - HTTPS support

2. **Features**
   - Workout templates
   - Progress charts
   - Friend system
   - Email notifications

3. **Performance**
   - Database indexes (already added)
   - Caching layer
   - API endpoints

4. **Mobile**
   - Responsive design improvements
   - Mobile app version

---

## 📞 File Reference

### Java Files Location
```
src/main/java/com/fitness/
├── model/
│   ├── User.java
│   └── Workout.java
├── servlet/
│   ├── AuthServlet.java
│   ├── WorkoutServlet.java
│   └── ProfileServlet.java
├── dao/
│   ├── UserDAO.java
│   └── WorkoutDAO.java
└── util/
    └── DBConnection.java
```

### JSP Files Location
```
src/main/webapp/
├── login.jsp
├── signup.jsp
├── dashboard.jsp
├── addWorkout.jsp
├── viewWorkouts.jsp
├── editWorkout.jsp
├── profile.jsp
└── index.jsp
```

### Config Files
```
src/main/webapp/WEB-INF/
└── web.xml

Root Files
├── database_setup.sql
├── README.md
└── IMPLEMENTATION.md
```

---

## ✨ You're All Set!

The complete fitness platform is ready to use:
- ✅ Backend: Java Servlets & JSP
- ✅ Database: MySQL with JDBC
- ✅ Frontend: Modern responsive UI
- ✅ Features: Full CRUD operations
- ✅ Security: Input validation & prepared statements

**Happy Coding! 🎉**
