package com.fitness.servlet;

import com.fitness.dao.UserDAO;
import com.fitness.dao.WorkoutDAO;
import com.fitness.model.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    private WorkoutDAO workoutDAO = new WorkoutDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = userDAO.getUserById(userId);
        int totalCalories = workoutDAO.getTotalCalories(userId);
        int totalWorkouts = userDAO.getUserById(userId) != null ? 1 : 0;

        request.setAttribute("user", user);
        request.setAttribute("totalCalories", totalCalories);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullname");
        String weight = request.getParameter("weight");
        String height = request.getParameter("height");
        String age = request.getParameter("age");

        User user = new User();
        user.setUserId(userId);
        user.setFullName(fullName);
        if (weight != null && !weight.isEmpty()) {
            user.setWeight(Double.parseDouble(weight));
        }
        if (height != null && !height.isEmpty()) {
            user.setHeight(Double.parseDouble(height));
        }
        user.setAge(age);

        // Optional profile fields: gender, goal and activity level
        String gender = request.getParameter("gender"); // "male" or "female"
        String goal = request.getParameter("goal"); // "maintain", "lose", "gain"
        String activity = request.getParameter("activity"); // sedentary, light, moderate, active, very_active

        // store in session so other pages can access
        if (gender != null) session.setAttribute("gender", gender);
        if (goal != null) session.setAttribute("goal", goal);
        if (activity != null) session.setAttribute("activity", activity);

        // compute recommended daily calories (BMR -> TDEE -> goal adjust)
        try {
            double w = user.getWeight() > 0 ? user.getWeight() : 70; // kg
            double h = user.getHeight() > 0 ? user.getHeight() : 170; // cm
            int a = 30;
            try { if (age != null && !age.isEmpty()) a = Integer.parseInt(age); } catch (Exception ex) {}

            double bmr;
            if ("female".equalsIgnoreCase(gender)) {
                bmr = 10 * w + 6.25 * h - 5 * a - 161;
            } else {
                bmr = 10 * w + 6.25 * h - 5 * a + 5;
            }

            double activityMultiplier = 1.2; // default sedentary
            if ("light".equals(activity)) activityMultiplier = 1.375;
            else if ("moderate".equals(activity)) activityMultiplier = 1.55;
            else if ("active".equals(activity)) activityMultiplier = 1.725;
            else if ("very_active".equals(activity)) activityMultiplier = 1.9;

            double tdee = bmr * activityMultiplier;
            double recommended = tdee;
            if ("lose".equals(goal)) recommended = tdee - 500;
            else if ("gain".equals(goal)) recommended = tdee + 500;

            int dailyGoal = (int) Math.max(1200, Math.round(recommended));
            session.setAttribute("dailyGoal", dailyGoal);
            session.setAttribute("recommendedCalories", (int)Math.round(tdee));
        } catch (Exception e) {
            // ignore computation errors, do not block profile update
            e.printStackTrace();
        }

        if (userDAO.updateUserProfile(user)) {
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        User updatedUser = userDAO.getUserById(userId);
        int totalCalories = workoutDAO.getTotalCalories(userId);
        request.setAttribute("user", updatedUser);
        request.setAttribute("totalCalories", totalCalories);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
