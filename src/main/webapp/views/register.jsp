<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - infaQ</title>
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

        .register-container {
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
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
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

        .login-link {
            text-align: center;
            color: #666;
        }

        .login-link a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .required {
            color: #f44336;
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="logo">
        <h1>Join infaQ</h1>
        <p class="subtitle">Create an account to get started</p>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-error">
        <%= error %>
    </div>
    <%
        }
    %>

    <form method="POST" action="<%= request.getContextPath() %>/register">
        <div class="form-group">
            <label for="username">Username <span class="required">*</span></label>
            <input type="text" id="username" name="username"
                   placeholder="Choose a username" required autofocus>
        </div>

        <div class="form-group">
            <label for="email">Email <span class="required">*</span></label>
            <input type="email" id="email" name="email"
                   placeholder="your.email@example.com" required>
        </div>

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName"
                   placeholder="Your full name">
        </div>

        <div class="form-group">
            <label for="password">Password <span class="required">*</span></label>
            <input type="password" id="password" name="password"
                   placeholder="Create a strong password" required minlength="6">
        </div>

        <button type="submit" class="btn btn-primary">Create Account</button>
    </form>

    <div class="divider">OR</div>

    <div class="login-link">
        Already have an account?
        <a href="<%= request.getContextPath() %>/login">Login here</a>
    </div>
</div>
</body>
</html>