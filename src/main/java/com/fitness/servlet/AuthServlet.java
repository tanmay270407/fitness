package com.fitness.servlet;

import com.fitness.dao.UserDAO;
import com.fitness.model.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("signup".equals(action)) {
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login.jsp");
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("signup".equals(action)) {
            handleSignup(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.loginUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleSignup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Validation
        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty() ||
            username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (userDAO.userExists(username)) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        User user = new User(fullName, email, username, password);
        if (userDAO.registerUser(user)) {
            request.setAttribute("success", "Account created successfully! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
