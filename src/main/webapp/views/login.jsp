<!-- login.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - infaQ</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 10px;
            font-size: 2em;
            font-weight: bold;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        .alert {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid;
        }

        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-color: #ef5350;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-color: #66bb6a;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #666;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
            font-weight: normal;
        }

        .btn-primary {
            background: #333;
            color: white;
            margin-bottom: 15px;
        }

        .btn-primary:hover {
            background: #555;
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            color: #999;
            position: relative;
        }

        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background-color: #ddd;
        }

        .divider::before {
            left: 0;
        }

        .divider::after {
            right: 0;
        }

        .register-link {
            text-align: center;
            color: #666;
        }

        .register-link a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <h1>infaQ</h1>
        <p class="subtitle">Login to share and support causes</p>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        String registered = request.getParameter("registered");

        if (error != null) {
    %>
    <div class="alert alert-error">
        <%= error %>
    </div>
    <%
        }

        if ("true".equals(registered)) {
    %>
    <div class="alert alert-success">
        Registration successful! Please login.
    </div>
    <%
        }
    %>

    <form method="POST" action="<%= request.getContextPath() %>/login">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username"
                   placeholder="Enter your username" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
    </form>

    <div class="divider">OR</div>

    <div class="register-link">
        Don't have an account?
        <a href="<%= request.getContextPath() %>/register">Sign up here</a>
    </div>
</div>
</body>
</html>