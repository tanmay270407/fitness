<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitness.model.User" %>
<%@ page import="com.fitness.dao.WorkoutDAO" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
    int userId = (Integer) session.getAttribute("userId");
    
    WorkoutDAO workoutDAO = new WorkoutDAO();
    int totalCalories = workoutDAO.getTotalCalories(userId);
    int totalWorkouts = workoutDAO.getUserWorkouts(userId).size();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Fitness Tracker</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        header .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h1 {
            font-size: 28px;
        }
        header nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            transition: opacity 0.3s;
        }
        header nav a:hover {
            opacity: 0.8;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .welcome {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .welcome h2 {
            color: #667eea;
            margin-bottom: 10px;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .stat-card h3 {
            color: #667eea;
            font-size: 14px;
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        .stat-card .value {
            font-size: 36px;
            font-weight: bold;
            color: #764ba2;
        }
        .actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: 600;
            transition: transform 0.2s;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Fitness Tracker</h1>
            <nav>
                <a href="profile">Profile</a>
                <a href="workout">Workouts</a>
                <a href="auth?action=logout">Logout</a>
            </nav>
        </div>
    </header>
    
    <div class="container">
        <div class="welcome">
            <h2>Welcome back, <%= fullName %>!</h2>
            <p>Track your fitness journey and monitor your progress.</p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <h3>Total Workouts</h3>
                <div class="value"><%= totalWorkouts %></div>
            </div>
            <div class="stat-card">
                <h3>Calories Burned</h3>
                <div class="value"><%= totalCalories %></div>
            </div>
        </div>
        
        <div class="actions">
            <a href="workout" class="btn">+ Add Workout</a>
            <a href="workout?action=view" class="btn">View Workouts</a>
            <a href="profile" class="btn">Update Profile</a>
        </div>
    </div>
</body>
</html>
