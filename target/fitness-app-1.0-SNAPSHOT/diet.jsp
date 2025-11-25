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
    <meta name="description" content="Track your daily meals and monitor calorie intake">
    <title>Diet Tracker - FitTrack</title>
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
                <li><a href="diet.jsp" class="active">Diet Tracker</a></li>
                <li><a href="exercise.jsp">Exercise Tracker</a></li>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="auth?action=logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="diet-tracker">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <span class="text-gradient">Diet Tracker</span>
                </h1>
                <p class="page-subtitle">Track your meals and monitor your daily calorie intake</p>
            </div>

            <!-- Dashboard Cards -->
            <div class="dashboard-grid">
                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--primary-gradient);">🔥</div>
                        <div>
                            <div class="card-label">Total Calories</div>
                            <div class="card-value" id="totalCalories">0</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--accent-gradient);">🎯</div>
                        <div>
                            <div class="card-label">Daily Goal</div>
                            <div class="card-value" id="dailyGoal">2000</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--success-gradient);">⚡</div>
                        <div>
                            <div class="card-label">Remaining</div>
                            <div class="card-value" id="remainingCalories">2000</div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-card card card-glass">
                    <div class="card-header">
                        <div class="card-icon" style="background: var(--secondary-gradient);">🍽️</div>
                        <div>
                            <div class="card-label">Meals Today</div>
                            <div class="card-value" id="mealsCount">0</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Progress Bar -->
            <div class="progress-section card card-glass">
                <div class="progress-header">
                    <h3>Daily Progress</h3>
                    <span id="progressPercentage">0%</span>
                </div>
                <div class="progress-container">
                    <div class="progress-bar" id="calorieProgress" style="width: 0%"></div>
                </div>
                <div class="progress-footer">
                    <span>0 cal</span>
                    <span id="goalText">Goal: 2000 cal</span>
                </div>
            </div>

            <!-- Main Grid -->
            <div class="content-grid">
                <!-- Add Meal Form -->
                <div class="form-section card card-glass">
                    <h2 class="section-heading">
                        <span class="heading-icon">➕</span>
                        Add Meal
                    </h2>

                    <form id="mealForm">
                        <div class="form-group">
                            <label for="mealName">Meal Name</label>
                            <input type="text" id="mealName" placeholder="e.g., Grilled Chicken Salad" required>
                        </div>

                        <div class="form-group">
                            <label for="mealType">Meal Type</label>
                            <select id="mealType" required>
                                <option value="breakfast">Breakfast</option>
                                <option value="lunch">Lunch</option>
                                <option value="dinner">Dinner</option>
                                <option value="snack">Snack</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="mealCalories">Calories</label>
                            <input type="number" id="mealCalories" placeholder="e.g., 350" required>
                        </div>

                        <div class="form-group">
                            <label for="mealNotes">Notes (optional)</label>
                            <textarea id="mealNotes" placeholder="Add any notes..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            Add Meal
                        </button>
                    </form>
                </div>

                <!-- Meals List -->
                <div class="meals-section card card-glass">
                    <h2 class="section-heading">
                        <span class="heading-icon">📋</span>
                        Today's Meals
                    </h2>

                    <div id="mealsList" class="meals-list">
                        <div class="empty-state">
                            <div class="empty-icon">🍽️</div>
                            <p>No meals logged yet</p>
                            <span>Start by adding your first meal above</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <style>
        .diet-tracker {
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

        .progress-section {
            padding: var(--spacing-lg);
            margin-bottom: var(--spacing-lg);
        }

        .progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-sm);
        }

        .progress-header h3 {
            font-size: var(--font-size-lg);
            font-weight: 600;
        }

        .progress-header span {
            font-weight: 700;
            color: var(--success-color);
        }

        .progress-footer {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-xs);
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: var(--spacing-lg);
        }

        .form-section,
        .meals-section {
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

        .meals-list {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-sm);
        }

        .meal-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all var(--transition-base);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .meal-item:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateX(4px);
        }

        .meal-info {
            flex: 1;
        }

        .meal-header {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            margin-bottom: 4px;
        }

        .meal-type-badge {
            font-size: 1.2rem;
        }

        .meal-name {
            font-weight: 600;
            font-size: var(--font-size-base);
        }

        .meal-type {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
            text-transform: capitalize;
        }

        .meal-calories {
            font-size: var(--font-size-lg);
            font-weight: 700;
            color: var(--accent-color);
            margin-right: var(--spacing-sm);
        }

        .meal-delete {
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

        .meal-delete:hover {
            background: rgba(245, 87, 108, 0.3);
            transform: scale(1.05);
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
        }

        @media (max-width: 480px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: var(--font-size-2xl);
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

        // Handle meal form
        document.getElementById('mealForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const name = document.getElementById('mealName').value;
            const type = document.getElementById('mealType').value;
            const calories = parseInt(document.getElementById('mealCalories').value);
            const notes = document.getElementById('mealNotes').value;

            addMeal(name, type, calories, notes);
            this.reset();
            updateProgressBar();
        });

        function addMeal(name, type, calories, notes) {
            const mealsList = document.getElementById('mealsList');
            if (mealsList.querySelector('.empty-state')) {
                mealsList.innerHTML = '';
            }

            const mealItem = document.createElement('div');
            mealItem.className = 'meal-item';
            const emoji = { breakfast: '🌅', lunch: '🍛', dinner: '🍽️', snack: '🍿' }[type];

            mealItem.innerHTML = `
                <div class="meal-info">
                    <div class="meal-header">
                        <span class="meal-type-badge">${emoji}</span>
                        <div>
                            <div class="meal-name">${name}</div>
                            <div class="meal-type">${type}</div>
                        </div>
                    </div>
                </div>
                <div class="meal-calories">${calories} cal</div>
                <button class="meal-delete" onclick="this.parentElement.remove(); updateProgressBar();">Delete</button>
            `;
            mealsList.appendChild(mealItem);
            updateMetrics();
        }

        function updateMetrics() {
            const meals = document.querySelectorAll('.meal-item');
            let total = 0;
            meals.forEach(meal => {
                const calories = parseInt(meal.querySelector('.meal-calories').textContent);
                total += calories;
            });

            document.getElementById('totalCalories').textContent = total;
            document.getElementById('mealsCount').textContent = meals.length;
            document.getElementById('remainingCalories').textContent = Math.max(0, 2000 - total);
        }

        function updateProgressBar() {
            updateMetrics();
            const total = parseInt(document.getElementById('totalCalories').textContent);
            const percentage = Math.min(100, (total / 2000) * 100);
            document.getElementById('calorieProgress').style.width = percentage + '%';
            document.getElementById('progressPercentage').textContent = Math.round(percentage) + '%';
        }
    </script>
</body>
</html>
