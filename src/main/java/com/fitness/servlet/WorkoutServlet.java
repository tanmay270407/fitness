package com.fitness.servlet;

import com.fitness.dao.WorkoutDAO;
import com.fitness.model.Workout;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class WorkoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO = new WorkoutDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("view".equals(action)) {
            List<Workout> workouts = workoutDAO.getUserWorkouts(userId);
            request.setAttribute("workouts", workouts);
            request.getRequestDispatcher("viewWorkouts.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int workoutId = Integer.parseInt(request.getParameter("id"));
            Workout workout = workoutDAO.getWorkoutById(workoutId);
            request.setAttribute("workout", workout);
            request.getRequestDispatcher("editWorkout.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int workoutId = Integer.parseInt(request.getParameter("id"));
            workoutDAO.deleteWorkout(workoutId);
            response.sendRedirect("workout?action=view");
        } else {
            request.getRequestDispatcher("addWorkout.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            handleAddWorkout(request, response, userId);
        } else if ("update".equals(action)) {
            handleUpdateWorkout(request, response);
        }
    }

    private void handleAddWorkout(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        String workoutType = request.getParameter("workout_type");
        String workoutName = request.getParameter("workout_name");
        String duration = request.getParameter("duration");
        String calories = request.getParameter("calories");
        String description = request.getParameter("description");
        String workoutDate = request.getParameter("workout_date");

        if (workoutType == null || workoutType.isEmpty() || workoutName == null || workoutName.isEmpty() ||
            duration == null || duration.isEmpty() || calories == null || calories.isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields");
            request.getRequestDispatcher("addWorkout.jsp").forward(request, response);
            return;
        }

        Workout workout = new Workout(userId, workoutType, workoutName,
                Integer.parseInt(duration), Integer.parseInt(calories));
        workout.setDescription(description);
        workout.setWorkoutDate(workoutDate);

        if (workoutDAO.addWorkout(workout)) {
            request.setAttribute("success", "Workout added successfully!");
            response.sendRedirect("workout?action=view");
        } else {
            request.setAttribute("error", "Failed to add workout");
            request.getRequestDispatcher("addWorkout.jsp").forward(request, response);
        }
    }

    private void handleUpdateWorkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int workoutId = Integer.parseInt(request.getParameter("workout_id"));
        String workoutType = request.getParameter("workout_type");
        String workoutName = request.getParameter("workout_name");
        String duration = request.getParameter("duration");
        String calories = request.getParameter("calories");
        String description = request.getParameter("description");
        String workoutDate = request.getParameter("workout_date");

        Workout workout = new Workout();
        workout.setWorkoutId(workoutId);
        workout.setWorkoutType(workoutType);
        workout.setWorkoutName(workoutName);
        workout.setDuration(Integer.parseInt(duration));
        workout.setCalories(Integer.parseInt(calories));
        workout.setDescription(description);
        workout.setWorkoutDate(workoutDate);

        if (workoutDAO.updateWorkout(workout)) {
            response.sendRedirect("workout?action=view");
        } else {
            request.setAttribute("error", "Failed to update workout");
            request.setAttribute("workout", workout);
            request.getRequestDispatcher("editWorkout.jsp").forward(request, response);
        }
    }
}
