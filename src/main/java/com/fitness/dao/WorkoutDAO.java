package com.fitness.dao;

import com.fitness.model.Workout;
import com.fitness.util.DBConnection;
import java.sql.*;
import java.util.*;

public class WorkoutDAO {

    public boolean addWorkout(Workout workout) {
        String query = "INSERT INTO workouts (user_id, workout_type, workout_name, duration, calories, description, workout_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, workout.getUserId());
            pstmt.setString(2, workout.getWorkoutType());
            pstmt.setString(3, workout.getWorkoutName());
            pstmt.setInt(4, workout.getDuration());
            pstmt.setInt(5, workout.getCalories());
            pstmt.setString(6, workout.getDescription());
            pstmt.setString(7, workout.getWorkoutDate());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Workout> getUserWorkouts(int userId) {
        List<Workout> workouts = new ArrayList<>();
        String query = "SELECT * FROM workouts WHERE user_id = ? ORDER BY workout_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Workout workout = new Workout();
                workout.setWorkoutId(rs.getInt("workout_id"));
                workout.setUserId(rs.getInt("user_id"));
                workout.setWorkoutType(rs.getString("workout_type"));
                workout.setWorkoutName(rs.getString("workout_name"));
                workout.setDuration(rs.getInt("duration"));
                workout.setCalories(rs.getInt("calories"));
                workout.setDescription(rs.getString("description"));
                workout.setWorkoutDate(rs.getString("workout_date"));
                workout.setCreatedAt(rs.getString("created_at"));
                workouts.add(workout);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workouts;
    }

    public Workout getWorkoutById(int workoutId) {
        String query = "SELECT * FROM workouts WHERE workout_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, workoutId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Workout workout = new Workout();
                workout.setWorkoutId(rs.getInt("workout_id"));
                workout.setUserId(rs.getInt("user_id"));
                workout.setWorkoutType(rs.getString("workout_type"));
                workout.setWorkoutName(rs.getString("workout_name"));
                workout.setDuration(rs.getInt("duration"));
                workout.setCalories(rs.getInt("calories"));
                workout.setDescription(rs.getString("description"));
                workout.setWorkoutDate(rs.getString("workout_date"));
                workout.setCreatedAt(rs.getString("created_at"));
                return workout;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateWorkout(Workout workout) {
        String query = "UPDATE workouts SET workout_type = ?, workout_name = ?, duration = ?, calories = ?, description = ?, workout_date = ? WHERE workout_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, workout.getWorkoutType());
            pstmt.setString(2, workout.getWorkoutName());
            pstmt.setInt(3, workout.getDuration());
            pstmt.setInt(4, workout.getCalories());
            pstmt.setString(5, workout.getDescription());
            pstmt.setString(6, workout.getWorkoutDate());
            pstmt.setInt(7, workout.getWorkoutId());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteWorkout(int workoutId) {
        String query = "DELETE FROM workouts WHERE workout_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, workoutId);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalCalories(int userId) {
        String query = "SELECT SUM(calories) as total FROM workouts WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
