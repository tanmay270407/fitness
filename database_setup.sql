-- Fitness Tracker Database Setup Script
-- Create database
CREATE DATABASE IF NOT EXISTS fitness_db;
USE fitness_db;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    weight DOUBLE DEFAULT 0,
    height DOUBLE DEFAULT 0,
    age INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create workouts table
CREATE TABLE IF NOT EXISTS workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    workout_type VARCHAR(50) NOT NULL,
    workout_name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    calories INT NOT NULL,
    description TEXT,
    workout_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_user_id ON workouts(user_id);
CREATE INDEX idx_workout_date ON workouts(workout_date);

-- Sample data (optional)
-- INSERT INTO users (full_name, email, username, password, weight, height, age) 
-- VALUES ('Demo User', 'demo@fitness.com', 'demo', 'demo123', 75, 180, 25);
