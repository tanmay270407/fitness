<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Track your fitness journey with our modern diet and exercise tracking platform">
    <title>FitTrack - Your Personal Fitness Companion</title>
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
                <li><a href="index.jsp" class="active">Home</a></li>
                <li><a href="diet.jsp">Diet Tracker</a></li>
                <li><a href="exercise.jsp">Exercise Tracker</a></li>
                <li id="authLinkContainer">
                    <% 
                        if (session.getAttribute("userId") != null) {
                            out.print("<a href='dashboard.jsp'>Dashboard</a>");
                        } else {
                            out.print("<a href='login.jsp'>Login / Register</a>");
                        }
                    %>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title fade-in">
                    Track Your Fitness Goals
                </h1>
                <p class="hero-subtitle fade-in">
                    Monitor your diet and exercise with precision. Achieve your fitness dreams with our comprehensive tracking platform.
                </p>
                <div class="hero-cta fade-in">
                    <% if (session.getAttribute("userId") != null) { %>
                        <a href="dashboard.jsp" class="btn btn-primary">Go to Dashboard</a>
                        <a href="exercise.jsp" class="btn btn-outline">Start Tracking</a>
                    <% } else { %>
                        <a href="signup.jsp" class="btn btn-primary">Get Started Free</a>
                        <a href="login.jsp" class="btn btn-outline">Sign In</a>
                    <% } %>
                </div>
            </div>
            <div class="hero-visual">
                <div class="floating-card card-1">
                    <div class="stat-icon">💪</div>
                    <div class="stat-value">500+</div>
                    <div class="stat-label">Users Active</div>
                </div>
                <div class="floating-card card-2">
                    <div class="stat-icon">🔥</div>
                    <div class="stat-value">10K+</div>
                    <div class="stat-label">Calories Tracked</div>
                </div>
                <div class="floating-card card-3">
                    <div class="stat-icon">⭐</div>
                    <div class="stat-value">4.8★</div>
                    <div class="stat-label">App Rating</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <h2 class="section-title text-center">
                Everything You Need to <span class="text-gradient">Succeed</span>
            </h2>
            <p class="section-subtitle text-center">
                Powerful features to help you reach your fitness goals faster
            </p>
            
            <div class="grid grid-3 mt-4">
                <div class="feature-card card card-glass fade-in">
                    <div class="feature-icon">📊</div>
                    <h3>Diet Tracking</h3>
                    <p>Log your meals and monitor your daily calorie intake with our easy-to-use tracker.</p>
                </div>
                
                <div class="feature-card card card-glass fade-in" style="animation-delay: 0.1s;">
                    <div class="feature-icon">💪</div>
                    <h3>Exercise Logging</h3>
                    <p>Record all your workouts, track duration, and monitor calories burned during each session.</p>
                </div>
                
                <div class="feature-card card card-glass fade-in" style="animation-delay: 0.2s;">
                    <div class="feature-icon">📈</div>
                    <h3>Progress Analytics</h3>
                    <p>Get detailed insights into your fitness journey with comprehensive statistics and trends.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-number">100K+</div>
                    <div class="stat-text">Meals Logged</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">50K+</div>
                    <div class="stat-text">Workouts Tracked</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">99.9%</div>
                    <div class="stat-text">Uptime</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">24/7</div>
                    <div class="stat-text">Support</div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-card card">
                <h2 class="cta-title">Ready to Transform Your Fitness?</h2>
                <p class="cta-text">Join thousands of users who have achieved their fitness goals with FitTrack.</p>
                <div class="cta-buttons">
                    <% if (session.getAttribute("userId") != null) { %>
                        <a href="dashboard.jsp" class="btn btn-primary">Go to Dashboard</a>
                    <% } else { %>
                        <a href="signup.jsp" class="btn btn-primary">Start Your Journey</a>
                        <a href="login.jsp" class="btn btn-outline">Already a Member?</a>
                    <% } %>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-brand">
                    <h3 style="color: var(--text-primary);">FitTrack</h3>
                    <p>Your personal fitness companion</p>
                </div>
                <div class="footer-links">
                    <a href="index.jsp">Home</a>
                    <a href="diet.jsp">Diet</a>
                    <a href="exercise.jsp">Exercise</a>
                    <a href="#">Privacy</a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 FitTrack. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <style>
        /* Hero Section */
        .hero {
            padding: var(--spacing-2xl) 0;
            min-height: 80vh;
            display: flex;
            align-items: center;
            position: relative;
        }

        .hero .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-xl);
            align-items: center;
        }

        .hero-content {
            z-index: 1;
        }

        .hero-title {
            font-size: var(--font-size-3xl);
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: var(--spacing-md);
            letter-spacing: -1px;
        }

        .hero-subtitle {
            font-size: var(--font-size-lg);
            color: var(--text-secondary);
            margin-bottom: var(--spacing-lg);
            line-height: 1.6;
        }

        .hero-cta {
            display: flex;
            gap: var(--spacing-md);
            flex-wrap: wrap;
        }

        .hero-visual {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            height: 240px;
            padding: 24px 12px;
        }

        .floating-card {
            position: relative;
            background: var(--bg-card);
            border: 1px solid rgba(31,41,55,0.04);
            border-radius: 20px;
            padding: 18px 20px;
            text-align: center;
            width: 180px;
            box-shadow: var(--shadow-sm);
            transition: transform var(--transition-fast), box-shadow var(--transition-fast);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }

        .floating-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-md); }

        .card-1, .card-2, .card-3 {
            animation: float 3s ease-in-out infinite;
        }

        .card-1 { animation-delay: 0s; }
        .card-2 { animation-delay: 0.15s; }
        .card-3 { animation-delay: 0.3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }

        .stat-icon {
            margin-bottom: var(--spacing-xs);
            font-size: 2rem;
        }

        .stat-value {
            font-size: var(--font-size-2xl);
            font-weight: 700;
            color: var(--primary-color);
        }

        .stat-label {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
            margin-top: var(--spacing-xs);
        }

        /* Features Section */
        .features {
            padding: var(--spacing-2xl) 0;
        }

        .section-title {
            font-size: var(--font-size-2xl);
            font-weight: 700;
            margin-bottom: var(--spacing-sm);
        }

        .section-subtitle {
            font-size: var(--font-size-lg);
            color: var(--text-secondary);
            margin-bottom: var(--spacing-xl);
        }

        .feature-card {
            text-align: center;
            padding: var(--spacing-xl);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto var(--spacing-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            border-radius: 14px;
        }

        .feature-card h3 {
            font-size: var(--font-size-xl);
            margin-bottom: var(--spacing-sm);
        }

        .feature-card p {
            color: var(--text-secondary);
            margin-bottom: var(--spacing-md);
            line-height: 1.6;
        }

        /* Stats Section */
        .stats-section {
            padding: var(--spacing-2xl) 0;
            background: rgba(255, 255, 255, 0.02);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: var(--spacing-lg);
        }

        .stat-box {
            text-align: center;
            padding: var(--spacing-lg);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: var(--spacing-xs);
        }

        .stat-text {
            font-size: var(--font-size-base);
            color: var(--text-secondary);
        }

        /* CTA Section */
        .cta-section {
            padding: var(--spacing-2xl) 0;
        }

        .cta-card {
            text-align: center;
            padding: var(--spacing-2xl);
            background: var(--bg-card);
            position: relative;
            overflow: hidden;
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            color: var(--text-primary);
        }

        .cta-title {
            font-size: var(--font-size-2xl);
            font-weight: 700;
            margin-bottom: var(--spacing-sm);
            position: relative;
        }

        .cta-text {
            font-size: var(--font-size-lg);
            margin-bottom: var(--spacing-lg);
            opacity: 0.9;
            position: relative;
        }

        .cta-buttons {
            display: flex;
            gap: var(--spacing-md);
            justify-content: center;
            flex-wrap: wrap;
            position: relative;
        }

        /* Footer */
        .footer {
            background: var(--bg-card);
            padding: var(--spacing-xl) 0 var(--spacing-md);
            border-top: 1px solid rgba(31,41,55,0.04);
            box-shadow: 0 -6px 24px rgba(31,41,55,0.02);
            color: var(--text-secondary);
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-lg);
            flex-wrap: wrap;
            gap: var(--spacing-lg);
        }

        .footer-brand p {
            color: var(--text-secondary);
            margin-top: var(--spacing-xs);
        }

        .footer-links {
            display: flex;
            gap: var(--spacing-lg);
        }

        .footer-links a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: var(--transition-fast);
        }

        .footer-links a:hover {
            color: var(--text-primary);
        }

        .footer-bottom {
            text-align: center;
            padding-top: var(--spacing-md);
            border-top: 1px solid rgba(31,41,55,0.04);
            color: var(--text-secondary);
            font-size: var(--font-size-sm);
        }

        @media (max-width: 768px) {
            .hero .container {
                grid-template-columns: 1fr;
            }

            .hero-visual {
                flex-direction: column;
            }

            .hero-title {
                font-size: var(--font-size-2xl);
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .footer-content {
                flex-direction: column;
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

        // Intersection Observer for fade-in animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(el);
        });
    </script>
</body>
</html>
