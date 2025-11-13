<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Redirect to feed if already logged in
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/feed");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>infaQ - Share, Support, Make a Difference</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        /* Navigation Bar */
        .navbar {
            background: #ffffff;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            text-decoration: none;
            color: #333;
            font-size: 1.5em;
            font-weight: bold;
        }

        .navbar-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-link {
            text-decoration: none;
            color: #333;
            font-size: 15px;
            padding: 8px 14px;
            border-radius: 4px;
            transition: background 0.3s;
        }

        .nav-link:hover {
            background: #f0f0f0;
        }

        .btn-primary {
            background: #333;
            color: white;
            padding: 10px 22px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: normal;
            transition: background 0.3s, transform 0.3s;
        }

        .btn-primary:hover {
            background: #555;
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            max-width: 1200px;
            margin: 80px auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            flex-wrap: wrap;
            gap: 40px;
        }

        .hero-text {
            flex: 1;
            min-width: 300px;
        }

        .hero-text h1 {
            font-size: 3em;
            font-weight: bold;
            color: #222;
            margin-bottom: 20px;
        }

        .hero-text p {
            font-size: 1.2em;
            color: #666;
            margin-bottom: 30px;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn-secondary {
            border: 1px solid #333;
            color: #333;
            background: white;
            padding: 10px 22px;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #333;
            color: white;
        }

        .hero-image {
            flex: 1;
            min-width: 300px;
            height: 350px;
            background: #e0e0e0;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
            font-size: 1.2em;
        }


        .hero-image img {
            width: 100%;
            max-width: 800px; /* optional, limits hero width */
            height: auto;
            border-radius: 20px; /* rounded corners like hero content */
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
            object-fit: cover;
            display: block;
            margin: 0 auto; /* centers the image */
        }


        /* Features Section */
        .features {
            background: white;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            padding: 80px 20px;
        }

        .features-grid {
            max-width: 1000px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 40px;
        }

        .feature {
            text-align: center;
        }

        .feature-icon {
            margin-bottom: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .feature-icon img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .feature-icon img:hover {
            transform: scale(1.1);
        }


        .feature-title {
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 8px;
        }

        .feature-desc {
            color: #666;
            font-size: 0.95em;
        }

        /* Stats Section */
        .stats {
            max-width: 1000px;
            margin: 80px auto;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            text-align: center;
            gap: 40px;
        }

        .stat {
            flex: 1;
            min-width: 200px;
        }

        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #333;
        }

        .stat-label {
            color: #666;
            font-size: 1em;
        }

        /* Footer */
        footer {
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/" class="navbar-brand">infaQ</a>
        <div class="navbar-links">
            <a href="#features" class="nav-link">Features</a>
            <a href="#stats" class="nav-link">Impact</a>
            <a href="<%= request.getContextPath() %>/login" class="nav-link">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn-primary">Get Started</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-text">
        <h1>Share. Support. Make a Difference.</h1>
        <p><b>infaQ</b> connects people who care. Start a cause, give, and see the difference.</p>
        <div class="hero-buttons">
            <a href="<%= request.getContextPath() %>/register" class="btn-primary">Create an Account</a>
            <a href="<%= request.getContextPath() %>/login" class="btn-secondary">Login</a>
        </div>
    </div>

    <div class="hero-image">
        <img src="images/donating.jpg" alt="Hero Image">
    </div>
</section>

<!-- Features Section -->
<section class="features" id="features">
    <div class="features-grid">
        <div class="feature">
            <div class="feature-icon"><img src="images/image-plus.png"></div>
            <div class="feature-title">Share Stories</div>
            <div class="feature-desc">Create posts with images to tell impactful stories that inspire others to give.</div>
        </div>
        <div class="feature">
            <div class="feature-icon"><img src="images/heart.png"></div>
            <div class="feature-title">Engage</div>
            <div class="feature-desc">Like, comment, and connect with others.</div>
        </div>
        <div class="feature">
            <div class="feature-icon"><img src="images/donate.png"></div>
            <div class="feature-title">Donate</div>
            <div class="feature-desc">Support verified causes directly and transparently.</div>
        </div>
        <div class="feature">
            <div class="feature-icon"><img src="images/progres.png"></div>
            <div class="feature-title">See Impact</div>
            <div class="feature-desc">Track progress and see how your contribution changes lives.</div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats" id="stats">
    <div class="stat">
        <div class="stat-number">0+</div>
        <div class="stat-label">Active Campaigns</div>
    </div>
    <div class="stat">
        <div class="stat-number">$0M+</div>
        <div class="stat-label">Funds Raised</div>
    </div>
    <div class="stat">
        <div class="stat-number">0K+</div>
        <div class="stat-label">Supporters</div>
    </div>
</section>

<!-- Footer -->
<footer>
    © <%= java.time.Year.now() %> infaQ. All rights reserved (Sofyane).
</footer>

</body>
</html>
