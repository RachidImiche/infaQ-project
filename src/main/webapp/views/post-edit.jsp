<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.donations.model.Post" %>
<%@ page import="com.donations.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Post - infaQ</title>
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

        .current-image {
            margin-bottom: 15px;
        }

        .current-image img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .image-actions {
            margin-top: 10px;
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #d32f2f;
            cursor: pointer;
        }

        .checkbox-label input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
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
            background: #ff9800;
            color: white;
        }

        .btn-primary:hover {
            background: #f57c00;
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

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
            color: #1565c0;
            font-size: 14px;
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

    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect(request.getContextPath() + "/feed");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>
        <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>" class="nav-link">Back to Post</a>
    </div>
</nav>

<div class="container">
    <div class="form-card">
        <h1>Edit Donation Post</h1>
        <p class="subtitle">Update your campaign details</p>

        <div class="info-box">
            Note: You cannot change the collected amount. It's automatically updated when people donate.
        </div>

        <%
            if (error != null) {
        %>
        <div class="alert alert-error">
            <%= error %>
        </div>
        <%
            }
        %>

        <form method="POST" action="<%= request.getContextPath() %>/posts/edit"
              enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= post.getId() %>">

            <div class="form-group">
                <label for="title">Post Title <span class="required">*</span></label>
                <input type="text" id="title" name="title" required
                       value="<%= post.getTitle() %>">
            </div>

            <div class="form-group">
                <label for="category">Category <span class="required">*</span></label>
                <select id="category" name="category" required>
                    <option value="">Select a category</option>
                    <option value="Education" <%= "Education".equals(post.getCategory()) ? "selected" : "" %>>Education</option>
                    <option value="Healthcare" <%= "Healthcare".equals(post.getCategory()) ? "selected" : "" %>>Healthcare</option>
                    <option value="Environment" <%= "Environment".equals(post.getCategory()) ? "selected" : "" %>>Environment</option>
                    <option value="Poverty Relief" <%= "Poverty Relief".equals(post.getCategory()) ? "selected" : "" %>>Poverty Relief</option>
                    <option value="Disaster Relief" <%= "Disaster Relief".equals(post.getCategory()) ? "selected" : "" %>>Disaster Relief</option>
                    <option value="Animal Welfare" <%= "Animal Welfare".equals(post.getCategory()) ? "selected" : "" %>>Animal Welfare</option>
                    <option value="Community Development" <%= "Community Development".equals(post.getCategory()) ? "selected" : "" %>>Community Development</option>
                    <option value="Other" <%= "Other".equals(post.getCategory()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description"><%= post.getDescription() != null ? post.getDescription() : "" %></textarea>
            </div>

            <div class="form-group">
                <label for="goalAmount">Funding Goal ($) <span class="required">*</span></label>
                <input type="number" id="goalAmount" name="goalAmount"
                       step="0.01" min="1" required
                       value="<%= post.getGoalAmount() %>">
                <div class="helper-text">Current collected: $<%= String.format("%.2f", post.getCollectedAmount()) %></div>
            </div>

            <div class="form-group">
                <label>Campaign Image</label>

                <%
                    if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) {
                %>
                <div class="current-image">
                    <p style="font-size: 14px; color: #666; margin-bottom: 10px;">Current image:</p>
                    <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
                         alt="Current post image" id="currentImage">
                    <div class="image-actions">
                        <label class="checkbox-label">
                            <input type="checkbox" name="removeImage" value="true" id="removeImageCheckbox">
                            <span>Remove current image</span>
                        </label>
                    </div>
                </div>
                <%
                    }
                %>

                <div style="margin-top: 15px;">
                    <p style="font-size: 14px; color: #666; margin-bottom: 10px;">Upload new image:</p>
                    <div class="file-input-wrapper">
                        <div class="file-input-button" id="fileInputButton">
                            Click to upload a new image (JPG, PNG, GIF - Max 5MB)
                        </div>
                        <input type="file" id="image" name="image"
                               accept="image/jpeg,image/jpg,image/png,image/gif">
                    </div>
                    <div class="file-preview" id="filePreview">
                        <img id="previewImage" src="" alt="Preview">
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
                   class="btn btn-secondary">
                    Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    Save Changes
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
    const removeCheckbox = document.getElementById('removeImageCheckbox');
    const currentImage = document.getElementById('currentImage');

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

            // Uncheck remove checkbox if new image is selected
            if (removeCheckbox) {
                removeCheckbox.checked = false;
            }
        } else {
            fileInputButton.textContent = 'Click to upload a new image (JPG, PNG, GIF - Max 5MB)';
            filePreview.style.display = 'none';
        }
    });

    // Handle remove checkbox
    if (removeCheckbox) {
        removeCheckbox.addEventListener('change', function() {
            if (this.checked && currentImage) {
                currentImage.style.opacity = '0.3';
            } else if (currentImage) {
                currentImage.style.opacity = '1';
            }
        });
    }
</script>
</body>
</html>