# Fitness Tracker Web Platform

A comprehensive fitness tracking web application built with Java Servlets, JSP, and JDBC.

## Features

- **User Authentication**: Login and signup functionality with session management
- **Workout Management**: Add, view, edit, and delete workouts
- **User Profile**: Update personal information (weight, height, age)
- **Statistics Dashboard**: View total workouts and calories burned
- **Responsive Design**: Clean and modern UI with gradient styling

## Project Structure

```
fitness/
├── src/main/java/
│   └── com/fitness/
│       ├── model/
│       │   ├── User.java
│       │   └── Workout.java
│       ├── servlet/
│       │   ├── AuthServlet.java
│       │   ├── WorkoutServlet.java
│       │   └── ProfileServlet.java
│       ├── dao/
│       │   ├── UserDAO.java
│       │   └── WorkoutDAO.java
│       └── util/
│           └── DBConnection.java
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml
│   ├── login.jsp
│   ├── signup.jsp
│   ├── dashboard.jsp
│   ├── addWorkout.jsp
│   ├── viewWorkouts.jsp
│   ├── editWorkout.jsp
│   ├── profile.jsp
│   └── index.jsp
└── database_setup.sql
```

## Technologies Used

- **Backend**: Java, Servlets, JSP
- **Database**: MySQL
- **Database Access**: JDBC (Java Database Connectivity)
- **Frontend**: HTML5, CSS3, JavaScript
- **Server**: Apache Tomcat (or any Servlet container)

## Prerequisites

1. **JDK 8** or higher
2. **Apache Tomcat 7** or higher
3. **MySQL Server**
4. **MySQL JDBC Driver** (mysql-connector-java.jar)

## Setup Instructions

### 1. Database Setup

1. Open MySQL command line or MySQL Workbench
2. Execute the `database_setup.sql` script:
   ```sql
   CREATE DATABASE fitness_db;
   USE fitness_db;
   -- Run the SQL script from database_setup.sql
   ```

### 2. JDBC Driver Installation

1. Download MySQL JDBC Driver from [MySQL Official Site](https://dev.mysql.com/downloads/connector/j/)
2. Copy `mysql-connector-java-x.x.x.jar` to: `WEB-INF/lib/`

### 3. Database Connection Configuration

Edit `src/main/java/com/fitness/util/DBConnection.java`:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/fitness_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password"; // Change to your MySQL password
```

### 4. Build and Deploy

1. **Using Eclipse IDE**:
   - Right-click project → Export → WAR file
   - Deploy to Tomcat

2. **Using Maven** (if configured):
   ```bash
   mvn clean package
   ```

3. **Manual Deployment**:
   - Copy the WAR file to Tomcat's `webapps/` folder
   - Restart Tomcat

### 5. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/fitness/
```

## Usage Flow

1. **Sign Up**: Create a new account with email and password
2. **Login**: Login with your credentials
3. **Dashboard**: View overview of your fitness journey
4. **Add Workout**: Log a new workout with type, duration, and calories
5. **View Workouts**: See all your logged workouts in a table
6. **Edit/Delete**: Modify or remove workouts
7. **Profile**: Update personal information

## Default Test Credentials

- **Username**: demo
- **Password**: demo123

(Add the test user from the commented SQL in database_setup.sql)

## API Endpoints

### Authentication
- `GET/POST /auth` - Login page and handler
- `GET/POST /auth?action=signup` - Signup page and handler
- `GET /auth?action=logout` - Logout

### Workouts
- `GET /workout` - Add workout form
- `GET/POST /workout?action=view` - View all workouts
- `GET /workout?action=edit&id={id}` - Edit workout form
- `GET /workout?action=delete&id={id}` - Delete workout

### Profile
- `GET /profile` - View profile
- `POST /profile` - Update profile

## Security Notes

⚠️ **Important**: This is a learning project. For production use:
1. **Never store plain text passwords** - Use password hashing (BCrypt, PBKDF2, etc.)
2. **Implement CSRF protection** - Use tokens in forms
3. **Use HTTPS** - For secure communication
4. **Validate all inputs** - Prevent SQL injection and XSS attacks
5. **Use prepared statements** - Already implemented in DAO classes
6. **Add input sanitization** - Filter and sanitize all user inputs

## Database Schema

### Users Table
```sql
- user_id (INT, PK, AUTO_INCREMENT)
- full_name (VARCHAR(100))
- email (VARCHAR(100), UNIQUE)
- username (VARCHAR(50), UNIQUE)
- password (VARCHAR(100))
- weight (DOUBLE)
- height (DOUBLE)
- age (INT)
- created_at (TIMESTAMP)
```

### Workouts Table
```sql
- workout_id (INT, PK, AUTO_INCREMENT)
- user_id (INT, FK)
- workout_type (VARCHAR(50))
- workout_name (VARCHAR(100))
- duration (INT)
- calories (INT)
- description (TEXT)
- workout_date (DATE)
- created_at (TIMESTAMP)
```

## Troubleshooting

### Issue: "mysql.jar not found"
- **Solution**: Ensure MySQL JDBC driver is in WEB-INF/lib/

### Issue: "Connection refused"
- **Solution**: Check if MySQL server is running and credentials are correct

### Issue: "Table doesn't exist"
- **Solution**: Run the database_setup.sql script to create tables

### Issue: Session not persisting
- **Solution**: Ensure session-config is properly set in web.xml

## Future Enhancements

- [ ] Password reset functionality
- [ ] Social sharing of achievements
- [ ] Workout templates and recommendations
- [ ] Advanced statistics and charts
- [ ] Mobile-friendly responsive design improvements
- [ ] Email notifications
- [ ] Workout history export to PDF
- [ ] Integration with fitness APIs
- [ ] User follow/friend system

## License

MIT License - Feel free to use this for learning purposes.

## Support

For issues or questions, please create an issue in your repository.

---

Happy Tracking! 💪

by Tanmay Kumar
