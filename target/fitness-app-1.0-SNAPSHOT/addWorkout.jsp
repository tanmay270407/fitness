<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("fullName");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Workout - Fitness Tracker</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            color: #667eea;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
        }
        .alert {
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        button,
        .btn {
            flex: 1;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        button:hover,
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: #6c757d;
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
                <a href="workout?action=view">Workouts</a>
                <a href="auth?action=logout">Logout</a>
            </nav>
        </div>
    </header>
    
    <div class="container">
        <div class="form-container">
            <h2>Add New Workout</h2>
            
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <%
                }
            %>
            
            <form method="POST" action="workout">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label for="workout_type">Workout Type</label>
                    <select id="workout_type" name="workout_type" required>
                        <option value="">Select a type</option>
                        <option value="Cardio">Cardio</option>
                        <option value="Strength">Strength</option>
                        <option value="Flexibility">Flexibility</option>
                        <option value="Sports">Sports</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="workout_name">Workout Name</label>
                    <input type="text" id="workout_name" name="workout_name" placeholder="e.g., Morning Run" required>
                </div>
                
                <div class="form-group">
                    <label for="duration">Duration (minutes)</label>
                    <input type="number" id="duration" name="duration" min="1" required>
                </div>
                
                <div class="form-group">
                    <label for="calories">Calories Burned</label>
                    <input type="number" id="calories" name="calories" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="workout_date">Date</label>
                    <input type="date" id="workout_date" name="workout_date" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" placeholder="Add any notes about your workout..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit">Add Workout</button>
                    <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
