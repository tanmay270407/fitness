<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitness.model.User" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = (User) request.getAttribute("user");
    int totalCalories = (Integer) request.getAttribute("totalCalories");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile - Fitness Tracker</title>
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
        .profile-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .profile-header h2 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 28px;
        }
        .profile-header p {
            color: #999;
        }
        .profile-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            margin-top: 5px;
        }
        .alert {
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
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
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: #667eea;
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
                <a href="workout?action=view">Workouts</a>
                <a href="auth?action=logout">Logout</a>
            </nav>
        </div>
    </header>
    
    <div class="container">
        <div class="profile-container">
            <% if (user != null) { %>
            
            <div class="profile-header">
                <h2><%= user.getFullName() %></h2>
                <p><%= user.getEmail() %></p>
            </div>
            
            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                if (error != null) {
            %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <%
                }
                if (success != null) {
            %>
                <div class="alert alert-success">
                    <%= success %>
                </div>
            <%
                }
            %>
            
            <div class="profile-stats">
                <div class="stat">
                    <div class="stat-value"><%= (int)user.getWeight() %></div>
                    <div class="stat-label">Weight (kg)</div>
                </div>
                <div class="stat">
                    <div class="stat-value"><%= (int)user.getHeight() %></div>
                    <div class="stat-label">Height (cm)</div>
                </div>
                <div class="stat">
                    <div class="stat-value"><%= user.getAge() != null ? user.getAge() : "N/A" %></div>
                    <div class="stat-label">Age</div>
                </div>
                <div class="stat">
                    <div class="stat-value"><%= totalCalories %></div>
                    <div class="stat-label">Total Calories</div>
                </div>
            </div>
            
            <form method="POST" action="profile">
                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" name="fullname" value="<%= user.getFullName() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" disabled>
                </div>
                
                <div class="form-group">
                    <label for="weight">Weight (kg)</label>
                    <input type="number" id="weight" name="weight" step="0.1" value="<%= user.getWeight() %>">
                </div>
                
                <div class="form-group">
                    <label for="height">Height (cm)</label>
                    <input type="number" id="height" name="height" step="0.1" value="<%= user.getHeight() %>">
                </div>
                
                <div class="form-group">
                    <label for="age">Age</label>
                    <input type="number" id="age" name="age" value="<%= user.getAge() != null ? user.getAge() : "" %>">
                </div>
                
                <div class="btn-group">
                    <button type="submit">Update Profile</button>
                    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </form>
            
            <% } %>
        </div>
    </div>
</body>
</html>
