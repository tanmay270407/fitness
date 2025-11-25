<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Track your workouts and monitor calories burned">
    <title>Exercise Tracker - FitTrack</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <!-- Navigation -->
    <nav>
        <div class="nav-container">
            <a href="index.jsp" class="logo">FitTrack</a>
            <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
            <ul class="nav-links" id="navLinks">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="diet.jsp">Diet Tracker</a></li>
                <li><a href="exercise.jsp" class="active">Exercise Tracker</a></li>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="auth?action=logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="exercise-tracker">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <span class="text-gradient">Exercise Tracker</span>
                </h1>
                <p class="page-subtitle">Log your workouts and track calories burned</p>
            </div>

            <!-- Dashboard Cards -->
            <div class="dashboard-grid">
                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--primary-gradient);">💪</div>
                        <div>
                            <div class="card-label">Total Workouts</div>
                            <div class="card-value" id="totalWorkouts">0</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--accent-gradient);">⏱️</div>
                        <div>
                            <div class="card-label">Total Duration</div>
                            <div class="card-value" id="totalDuration">0 min</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--success-gradient);">🔥</div>
                        <div>
                            <div class="card-label">Calories Burned</div>
                            <div class="card-value" id="totalCalories">0</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--secondary-gradient);">📊</div>
                        <div>
                            <div class="card-label">Avg Duration</div>
                            <div class="card-value" id="avgDuration">0 min</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Workout Type Summary -->
            <div class="summary-section card card-glass">
                <h3>Workout Type Breakdown</h3>
                <div class="type-summary" id="typeSummary">
                    <div class="type-item">
                        <span class="type-icon">🏃</span>
                        <span class="type-name">Running</span>
                        <span class="type-count" id="count-running">0</span>
                    </div>
                    <div class="type-item">
                        <span class="type-icon">🏋️</span>
                        <span class="type-name">Weightlifting</span>
                        <span class="type-count" id="count-weightlifting">0</span>
                    </div>
                    <div class="type-item">
                        <span class="type-icon">🧘</span>
                        <span class="type-name">Yoga</span>
                        <span class="type-count" id="count-yoga">0</span>
                    </div>
                    <div class="type-item">
                        <span class="type-icon">🚴</span>
                        <span class="type-name">Cycling</span>
                        <span class="type-count" id="count-cycling">0</span>
                    </div>
                </div>
            </div>

            <!-- Main Grid -->
            <div class="content-grid">
                <!-- Add Workout Form -->
                <div class="form-section card card-glass">
                    <h2 class="section-heading">
                        <span class="heading-icon">➕</span>
                        Log Workout
                    </h2>

                    <form id="workoutForm" method="POST" action="workout?action=add">
                        <div class="form-group">
                            <label for="workoutType">Workout Type</label>
                            <select id="workoutType" name="workout_type" required>
                                <option value="running">Running</option>
                                <option value="weightlifting">Weightlifting</option>
                                <option value="yoga">Yoga</option>
                                <option value="cycling">Cycling</option>
                                <option value="swimming">Swimming</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="workoutName">Exercise Name</label>
                            <input type="text" id="workoutName" name="workout_name" placeholder="e.g., Morning Run" required>
                        </div>

                        <div class="form-group">
                            <label for="workoutDuration">Duration (minutes)</label>
                            <input type="number" id="workoutDuration" name="duration" placeholder="e.g., 30" required>
                        </div>

                        <div class="form-group">
                            <label for="workoutCalories">Calories Burned</label>
                            <input type="number" id="workoutCalories" name="calories" placeholder="e.g., 250" required>
                        </div>

                        <div class="form-group">
                            <label for="workoutNotes">Notes (optional)</label>
                            <textarea id="workoutNotes" name="description" placeholder="Add any notes..."></textarea>
                            <input type="hidden" id="workoutDate" name="workout_date" value="">
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            Log Workout
                        </button>
                    </form>
                </div>

                <!-- Workouts List -->
                <div class="workouts-section card card-glass">
                    <h2 class="section-heading">
                        <span class="heading-icon">📋</span>
                        Today's Workouts
                    </h2>

                    <div id="workoutsList" class="workouts-list">
                        <div class="empty-state">
                            <div class="empty-icon">💪</div>
                            <p>No workouts logged yet</p>
                            <span>Start by logging your first workout above</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <style>
        .exercise-tracker {
            padding: var(--spacing-xl) 0;
            min-height: 100vh;
        }

        .page-header {
            text-align: center;
            margin-bottom: var(--spacing-xl);
        }

        .page-title {
            font-size: var(--font-size-3xl);
            font-weight: 800;
            margin-bottom: var(--spacing-sm);
        }

        .page-subtitle {
            font-size: var(--font-size-lg);
            color: var(--text-secondary);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
        }

        .dashboard-card {
            padding: var(--spacing-md);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .card-label {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
            margin-bottom: 4px;
        }

        .card-value {
            font-size: var(--font-size-2xl);
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .summary-section {
            padding: var(--spacing-lg);
            margin-bottom: var(--spacing-lg);
        }

        .summary-section h3 {
            font-size: var(--font-size-lg);
            font-weight: 600;
            margin-bottom: var(--spacing-md);
        }

        .type-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: var(--spacing-md);
        }

        .type-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            transition: all var(--transition-base);
        }

        .type-item:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateY(-2px);
        }

        .type-icon {
            font-size: 1.5rem;
        }

        .type-name {
            flex: 1;
            font-weight: 500;
        }

        .type-count {
            font-weight: 700;
            color: var(--accent-color);
            font-size: var(--font-size-lg);
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: var(--spacing-lg);
        }

        .form-section,
        .workouts-section {
            padding: var(--spacing-lg);
        }

        .section-heading {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-size: var(--font-size-xl);
            font-weight: 700;
            margin-bottom: var(--spacing-lg);
        }

        .heading-icon {
            font-size: 1.5rem;
        }

        .workouts-list {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-md);
        }

        .workout-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            transition: all var(--transition-base);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .workout-item:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateX(4px);
        }

        .workout-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: var(--spacing-sm);
        }

        .workout-title-section {
            flex: 1;
        }

        .workout-title-row {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            margin-bottom: 4px;
        }

        .workout-type-badge {
            font-size: 1.2rem;
        }

        .workout-name {
            font-weight: 600;
            font-size: var(--font-size-lg);
        }

        .workout-type {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
            text-transform: capitalize;
        }

        .workout-delete {
            background: rgba(245, 87, 108, 0.2);
            color: var(--warning-color);
            border: none;
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            cursor: pointer;
            font-size: var(--font-size-sm);
            font-weight: 600;
            transition: all var(--transition-base);
        }

        .workout-delete:hover {
            background: rgba(245, 87, 108, 0.3);
            transform: scale(1.05);
        }

        .workout-stats {
            display: flex;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-sm);
        }

        .workout-stat {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-size: var(--font-size-sm);
        }

        .workout-stat-icon {
            font-size: 1rem;
        }

        .workout-stat-value {
            font-weight: 600;
            color: var(--accent-color);
        }

        .empty-state {
            text-align: center;
            padding: var(--spacing-2xl) var(--spacing-lg);
        }

        .empty-icon {
            font-size: 4rem;
            margin-bottom: var(--spacing-md);
            opacity: 0.5;
        }

        .empty-state p {
            font-size: var(--font-size-lg);
            font-weight: 600;
            margin-bottom: var(--spacing-xs);
        }

        .empty-state span {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
        }

        @media (max-width: 968px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .type-summary {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .type-summary {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: var(--font-size-2xl);
            }

            .workout-stats {
                flex-direction: column;
                gap: var(--spacing-xs);
            }
        }
    </style>

    <script>
        // Mobile menu toggle
        const menuToggle = document.getElementById('menuToggle');
        const navLinks = document.getElementById('navLinks');

        menuToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });

        // Handle workout form — submit to server via fetch, and update UI immediately
        document.getElementById('workoutForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            const type = document.getElementById('workoutType').value;
            const name = document.getElementById('workoutName').value;
            const duration = parseInt(document.getElementById('workoutDuration').value);
            const calories = parseInt(document.getElementById('workoutCalories').value);
            const notes = document.getElementById('workoutNotes').value;

            // set hidden date value
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('workoutDate').value = today;

            // update UI immediately
            addWorkout(type, name, duration, calories, notes);

            // send data to server
            try {
                const formData = new FormData(this);
                // add action param expected by servlet
                formData.append('action', 'add');

                const res = await fetch(this.action, {
                    method: 'POST',
                    body: formData,
                    credentials: 'same-origin'
                });

                // if server redirects to another page (e.g., view), follow it
                if (res.redirected) {
                    window.location = res.url;
                    return;
                }

                // otherwise show a quick success state and reset form
                this.reset();
            } catch (err) {
                console.error('Failed to send workout to server', err);
            }
        });

        function addWorkout(type, name, duration, calories, notes) {
            const workoutsList = document.getElementById('workoutsList');
            if (workoutsList.querySelector('.empty-state')) {
                workoutsList.innerHTML = '';
            }

            const workoutItem = document.createElement('div');
            workoutItem.className = 'workout-item';
            const emoji = { running: '🏃', weightlifting: '🏋️', yoga: '🧘', cycling: '🚴', swimming: '🏊' }[type];

            workoutItem.innerHTML = `
                <div class="workout-header">
                    <div class="workout-title-section">
                        <div class="workout-title-row">
                            <span class="workout-type-badge">${emoji}</span>
                            <div>
                                <div class="workout-name">${name}</div>
                                <div class="workout-type">${type}</div>
                            </div>
                        </div>
                    </div>
                    <button class="workout-delete" onclick="this.closest('.workout-item').remove(); updateMetrics();">Delete</button>
                </div>
                <div class="workout-stats">
                    <div class="workout-stat">
                        <span class="workout-stat-icon">⏱️</span>
                        <span class="workout-stat-value">${duration} min</span>
                    </div>
                    <div class="workout-stat">
                        <span class="workout-stat-icon">🔥</span>
                        <span class="workout-stat-value">${calories} cal</span>
                    </div>
                </div>
                ${notes ? `<div style="font-size: var(--font-size-sm); color: var(--text-secondary); font-style: italic; padding: var(--spacing-xs); background: rgba(255, 255, 255, 0.02); border-radius: var(--radius-sm); border-left: 2px solid var(--primary-color);">${notes}</div>` : ''}
            `;
            workoutsList.appendChild(workoutItem);
            updateMetrics();
        }

        function updateMetrics() {
            const workouts = document.querySelectorAll('.workout-item');
            let totalDuration = 0, totalCalories = 0;
            const typeCounts = { running: 0, weightlifting: 0, yoga: 0, cycling: 0, swimming: 0 };

            workouts.forEach(workout => {
                const durationText = workout.querySelector('.workout-stat-value');
                const caloriesText = workout.querySelectorAll('.workout-stat-value')[1];
                const typeText = workout.querySelector('.workout-type').textContent.toLowerCase();
                
                totalDuration += parseInt(durationText.textContent);
                totalCalories += parseInt(caloriesText.textContent);
                if (typeText in typeCounts) typeCounts[typeText]++;
            });

            document.getElementById('totalWorkouts').textContent = workouts.length;
            document.getElementById('totalDuration').textContent = totalDuration + ' min';
            document.getElementById('totalCalories').textContent = totalCalories;
            document.getElementById('avgDuration').textContent = workouts.length ? Math.round(totalDuration / workouts.length) + ' min' : '0 min';

            for (let type in typeCounts) {
                document.getElementById('count-' + type).textContent = typeCounts[type];
            }
        }
    </script>
</body>

</html>
