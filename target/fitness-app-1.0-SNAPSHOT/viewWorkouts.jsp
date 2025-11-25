<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fitness.model.Workout" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Workouts - Fitness Tracker</title>
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
        header nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .page-header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .page-header h2 {
            color: #667eea;
        }
        .btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        thead {
            background: #f8f9fa;
            border-bottom: 2px solid #667eea;
        }
        th {
            padding: 15px;
            text-align: left;
            color: #667eea;
            font-weight: 600;
        }
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        tr:hover {
            background-color: #f8f9fa;
        }
        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-cardio {
            background-color: #e7f3ff;
            color: #0066cc;
        }
        .badge-strength {
            background-color: #fff3cd;
            color: #856404;
        }
        .badge-flexibility {
            background-color: #e7f7ed;
            color: #155724;
        }
        .badge-sports {
            background-color: #f8e5e5;
            color: #721c24;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .btn-small {
            padding: 8px 12px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-danger {
            background: #dc3545;
        }
        .btn-small:hover {
            opacity: 0.8;
        }
        .no-workouts {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Fitness Tracker</h1>
            <nav>
                <a href="dashboard.jsp">Dashboard</a>
                <a href="profile">Profile</a>
                <a href="auth?action=logout">Logout</a>
            </nav>
        </div>
    </header>
    
    <div class="container">
        <div class="page-header">
            <h2>My Workouts</h2>
            <a href="workout" class="btn">+ Add Workout</a>
        </div>
        
        <%
            List<Workout> workouts = (List<Workout>) request.getAttribute("workouts");
            if (workouts != null && !workouts.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Workout Name</th>
                    <th>Duration (min)</th>
                    <th>Calories</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Workout workout : workouts) {
                        String badgeClass = "badge-cardio";
                        if ("Strength".equals(workout.getWorkoutType())) {
                            badgeClass = "badge-strength";
                        } else if ("Flexibility".equals(workout.getWorkoutType())) {
                            badgeClass = "badge-flexibility";
                        } else if ("Sports".equals(workout.getWorkoutType())) {
                            badgeClass = "badge-sports";
                        }
                %>
                <tr>
                    <td><%= workout.getWorkoutDate() %></td>
                    <td><span class="badge <%= badgeClass %>"><%= workout.getWorkoutType() %></span></td>
                    <td><%= workout.getWorkoutName() %></td>
                    <td><%= workout.getDuration() %></td>
                    <td><%= workout.getCalories() %></td>
                    <td>
                        <div class="action-buttons">
                            <a href="workout?action=edit&id=<%= workout.getWorkoutId() %>" class="btn-small">Edit</a>
                            <a href="workout?action=delete&id=<%= workout.getWorkoutId() %>" class="btn-small btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <div class="no-workouts">
            <p>No workouts yet. <a href="workout">Add your first workout</a>!</p>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
