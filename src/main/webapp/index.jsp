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
    <title>DonationsApp - Share, Support, Make a Difference</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .hero-container {
            text-align: center;
            max-width: 900px;
        }

        .hero-content {
            background: rgba(255, 255, 255, 0.95);
            padding: 60px 50px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        .logo {
            font-size: 5em;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        h1 {
            font-size: 3em;
            color: #333;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .tagline {
            font-size: 1.4em;
            color: #666;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .feature {
            padding: 20px;
        }

        .feature-icon {
            font-size: 3em;
            margin-bottom: 10px;
        }

        .feature-title {
            font-size: 1.2em;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .feature-desc {
            color: #666;
            font-size: 0.95em;
        }

        .cta-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 16px 40px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .stats {
            display: flex;
            justify-content: center;
            gap: 50px;
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #e0e0e0;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 1em;
        }
    </style>
</head>
<body>
<div class="hero-container">
    <div class="hero-content">
        <div class="logo">🎁</div>
        <h1>DonationsApp</h1>
        <p class="tagline">
            The social platform where generosity meets community.<br>
            Share causes, support dreams, and make a real difference.
        </p>

        <div class="features">
            <div class="feature">
                <div class="feature-icon">📸</div>
                <div class="feature-title">Share Stories</div>
                <div class="feature-desc">Post with images and tell compelling stories</div>
            </div>
            <div class="feature">
                <div class="feature-icon">❤️</div>
                <div class="feature-title">Engage</div>
                <div class="feature-desc">Like, comment, and show support</div>
            </div>
            <div class="feature">
                <div class="feature-icon">💚</div>
                <div class="feature-title">Donate</div>
                <div class="feature-desc">Contribute to causes that matter</div>
            </div>
            <div class="feature">
                <div class="feature-icon">🌍</div>
                <div class="feature-title">Make Impact</div>
                <div class="feature-desc">Track progress and see results</div>
            </div>
        </div>

        <div class="cta-buttons">
            <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">
                Get Started - It's Free
            </a>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">
                Login to Your Account
            </a>
        </div>

        <div class="stats">
            <div class="stat-item">
                <div class="stat-number">1000+</div>
                <div class="stat-label">Active Campaigns</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">$2M+</div>
                <div class="stat-label">Funds Raised</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">10K+</div>
                <div class="stat-label">Supporters</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>