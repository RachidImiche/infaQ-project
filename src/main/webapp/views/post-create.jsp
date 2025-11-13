<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.donations.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Post - infaQ</title>
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
        }

        /* Navigation Bar */
        .navbar {
            background: white;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
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

        .nav-link {
            text-decoration: none;
            color: #333;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.3s;
        }

        .nav-link:hover {
            background: #f0f0f0;
        }

        /* Main Content */
        .container {
            max-width: 680px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .form-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 30px;
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 1.8em;
        }

        .subtitle {
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
            font-size: 14px;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #666;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }

        .file-input-button {
            padding: 12px;
            background: #f9f9f9;
            border: 1px dashed #ccc;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
        }

        .file-input-button:hover {
            border-color: #666;
            background: #f0f0f0;
        }

        .file-input-wrapper input[type="file"] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }

        .file-preview {
            margin-top: 15px;
            display: none;
        }

        .file-preview img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
            font-weight: normal;
            text-decoration: none;
            text-align: center;
        }

        .btn-primary {
            background: #333;
            color: white;
        }

        .btn-primary:hover {
            background: #555;
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #d0d0d0;
        }

        .required {
            color: #f44336;
        }

        .helper-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>
        <a href="<%= request.getContextPath() %>/feed" class="nav-link">Back to Feed</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="form-card">
        <h1>Create Donation Post</h1>
        <p class="subtitle">Share your cause and start raising funds</p>

        <%
            if (error != null) {
        %>
        <div class="alert alert-error">
            <%= error %>
        </div>
        <%
            }
        %>

        <form method="POST" action="<%= request.getContextPath() %>/posts/create"
              enctype="multipart/form-data">

            <div class="form-group">
                <label for="title">Post Title <span class="required">*</span></label>
                <input type="text" id="title" name="title" required
                       placeholder="Give your campaign a compelling title">
                <div class="helper-text">Make it clear and engaging</div>
            </div>

            <div class="form-group">
                <label for="category">Category <span class="required">*</span></label>
                <select id="category" name="category" required>
                    <option value="">Select a category</option>
                    <option value="Education">Education</option>
                    <option value="Healthcare">Healthcare</option>
                    <option value="Environment">Environment</option>
                    <option value="Poverty Relief">Poverty Relief</option>
                    <option value="Disaster Relief">Disaster Relief</option>
                    <option value="Animal Welfare">Animal Welfare</option>
                    <option value="Community Development">Community Development</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description"
                          placeholder="Tell your story... Why is this cause important? How will the funds be used?"></textarea>
                <div class="helper-text">Share the details and impact of your campaign</div>
            </div>

            <div class="form-group">
                <label for="goalAmount">Funding Goal ($) <span class="required">*</span></label>
                <input type="number" id="goalAmount" name="goalAmount"
                       step="0.01" min="1" required
                       placeholder="5000.00">
                <div class="helper-text">Set a realistic fundraising goal</div>
            </div>

            <div class="form-group">
                <label for="image">Campaign Image</label>
                <div class="file-input-wrapper">
                    <div class="file-input-button" id="fileInputButton">
                        Click to upload an image (JPG, PNG, GIF - Max 5MB)
                    </div>
                    <input type="file" id="image" name="image"
                           accept="image/jpeg,image/jpg,image/png,image/gif">
                </div>
                <div class="file-preview" id="filePreview">
                    <img id="previewImage" src="" alt="Preview">
                </div>
                <div class="helper-text">Add an engaging image to attract supporters</div>
            </div>

            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/feed" class="btn btn-secondary">
                    Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    Create Post
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Image preview functionality
    const fileInput = document.getElementById('image');
    const fileInputButton = document.getElementById('fileInputButton');
    const filePreview = document.getElementById('filePreview');
    const previewImage = document.getElementById('previewImage');

    fileInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            fileInputButton.textContent = file.name;

            const reader = new FileReader();
            reader.onload = function(e) {
                previewImage.src = e.target.result;
                filePreview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            fileInputButton.textContent = 'Click to upload an image (JPG, PNG, GIF - Max 5MB)';
            filePreview.style.display = 'none';
        }
    });
</script>
</body>
</html>