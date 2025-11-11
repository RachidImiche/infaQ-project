<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.donations.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - DonationsApp</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
        }

        .navbar {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: #333;
            font-size: 1.5em;
            font-weight: bold;
        }

        .nav-link {
            text-decoration: none;
            color: #333;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .nav-link:hover {
            background: #f0f2f5;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .edit-card {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .card-header {
            margin-bottom: 30px;
        }

        .card-title {
            font-size: 2em;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .card-subtitle {
            color: #666;
            font-size: 1em;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea.form-input {
            resize: vertical;
            min-height: 120px;
        }

        .profile-image-section {
            margin-bottom: 30px;
        }

        .current-image-wrapper {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .current-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 36px;
            flex-shrink: 0;
            overflow: hidden;
            border: 4px solid white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .current-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-info {
            flex: 1;
        }

        .image-info-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .image-info-text {
            color: #666;
            font-size: 14px;
        }

        .file-input-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .file-input {
            display: none;
        }

        .file-input-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 12px 20px;
            background: #667eea;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
        }

        .file-input-label:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .file-name {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
            padding: 8px 12px;
            background: #f8f9fa;
            border-radius: 6px;
            display: none;
        }

        .file-name.show {
            display: block;
        }

        .checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px;
            background: #fff3cd;
            border: 1px solid #ffc107;
            border-radius: 8px;
            margin-top: 15px;
        }

        .checkbox-input {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .checkbox-label {
            cursor: pointer;
            color: #856404;
            font-weight: 500;
            font-size: 14px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e0e0e0;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f0f2f5;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e2e5;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        .alert-success {
            background: #efe;
            color: #3c3;
            border: 1px solid #cfc;
        }

        .helper-text {
            font-size: 13px;
            color: #666;
            margin-top: 6px;
        }

        .char-counter {
            font-size: 12px;
            color: #999;
            text-align: right;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .edit-card {
                padding: 25px;
            }

            .form-actions {
                flex-direction: column;
            }

            .current-image-wrapper {
                flex-direction: column;
                text-align: center;
            }
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

    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = currentUser;
    }

    String error = (String) request.getAttribute("error");
%>

<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            <span>🎁</span> DonationsApp
        </a>
        <a href="<%= request.getContextPath() %>/profile" class="nav-link">← Back to Profile</a>
    </div>
</nav>

<div class="container">
    <div class="edit-card">
        <div class="card-header">
            <h1 class="card-title">✏️ Edit Profile</h1>
            <p class="card-subtitle">Update your profile information</p>
        </div>

        <% if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-error">
            <span>⚠️</span>
            <span><%= error %></span>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/profile/edit" method="post" enctype="multipart/form-data">
            <!-- Profile Picture Section -->
            <div class="profile-image-section">
                <label class="form-label">Profile Picture</label>

                <div class="current-image-wrapper">
                    <div class="current-avatar">
                        <% if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/<%= user.getProfileImage() %>"
                                 alt="<%= user.getUsername() %>"
                                 id="previewImage">
                        <% } else { %>
                            <span id="avatarInitial"><%= user.getUsername().substring(0, 1).toUpperCase() %></span>
                        <% } %>
                    </div>
                    <div class="image-info">
                        <div class="image-info-title">Current Profile Picture</div>
                        <div class="image-info-text">
                            <% if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) { %>
                                You have a profile picture set
                            <% } else { %>
                                No profile picture set (using default avatar)
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="file-input-wrapper">
                    <input type="file"
                           id="profileImage"
                           name="profileImage"
                           class="file-input"
                           accept="image/jpeg,image/png,image/gif"
                           onchange="handleFileSelect(this)">
                    <label for="profileImage" class="file-input-label">
                        <span>📷</span>
                        <span>Choose New Picture</span>
                    </label>
                    <div id="fileName" class="file-name"></div>
                </div>

                <p class="helper-text">
                    Accepted formats: JPG, PNG, GIF. Max size: 5MB
                </p>

                <% if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) { %>
                <div class="checkbox-wrapper">
                    <input type="checkbox"
                           id="removeImage"
                           name="removeImage"
                           value="true"
                           class="checkbox-input">
                    <label for="removeImage" class="checkbox-label">
                        🗑️ Remove current profile picture
                    </label>
                </div>
                <% } %>
            </div>

            <!-- Full Name -->
            <div class="form-group">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text"
                       id="fullName"
                       name="fullName"
                       class="form-input"
                       placeholder="Enter your full name"
                       value="<%= user.getFullName() != null ? user.getFullName() : "" %>"
                       maxlength="100">
                <p class="helper-text">Your full name as you'd like it to appear on your profile</p>
            </div>

            <!-- Bio -->
            <div class="form-group">
                <label for="bio" class="form-label">Bio</label>
                <textarea id="bio"
                          name="bio"
                          class="form-input"
                          placeholder="Tell us about yourself..."
                          maxlength="500"
                          oninput="updateCharCount(this)"><%= user.getBio() != null ? user.getBio() : "" %></textarea>
                <div class="char-counter">
                    <span id="charCount"><%= user.getBio() != null ? user.getBio().length() : 0 %></span>/500 characters
                </div>
                <p class="helper-text">A short description about yourself and your mission</p>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    <span>💾</span>
                    <span>Save Changes</span>
                </button>
                <a href="<%= request.getContextPath() %>/profile" class="btn btn-secondary">
                    <span>✖️</span>
                    <span>Cancel</span>
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Handle file selection and preview
    function handleFileSelect(input) {
        const fileName = document.getElementById('fileName');
        const previewImage = document.getElementById('previewImage');
        const avatarInitial = document.getElementById('avatarInitial');
        const removeCheckbox = document.getElementById('removeImage');

        if (input.files && input.files[0]) {
            const file = input.files[0];

            // Validate file size (5MB)
            if (file.size > 5 * 1024 * 1024) {
                alert('File size exceeds 5MB. Please choose a smaller file.');
                input.value = '';
                fileName.classList.remove('show');
                return;
            }

            // Validate file type
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Invalid file type. Please choose a JPG, PNG, or GIF image.');
                input.value = '';
                fileName.classList.remove('show');
                return;
            }

            // Show file name
            fileName.textContent = '📎 ' + file.name;
            fileName.classList.add('show');

            // Uncheck remove checkbox if checked
            if (removeCheckbox) {
                removeCheckbox.checked = false;
            }

            // Preview image
            const reader = new FileReader();
            reader.onload = function(e) {
                if (previewImage) {
                    previewImage.src = e.target.result;
                } else if (avatarInitial) {
                    // Replace initial with image
                    const avatar = document.querySelector('.current-avatar');
                    avatar.innerHTML = '<img src="' + e.target.result + '" alt="Preview" style="width:100%;height:100%;object-fit:cover;">';
                }
            };
            reader.readAsDataURL(file);
        } else {
            fileName.classList.remove('show');
        }
    }

    // Update character count for bio
    function updateCharCount(textarea) {
        const charCount = document.getElementById('charCount');
        charCount.textContent = textarea.value.length;
    }

    // Handle remove image checkbox
    const removeCheckbox = document.getElementById('removeImage');
    if (removeCheckbox) {
        removeCheckbox.addEventListener('change', function() {
            if (this.checked) {
                const fileInput = document.getElementById('profileImage');
                fileInput.value = '';
                document.getElementById('fileName').classList.remove('show');
            }
        });
    }

    // Form validation before submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const fullName = document.getElementById('fullName').value.trim();
        const bio = document.getElementById('bio').value.trim();
        const fileInput = document.getElementById('profileImage');
        const removeCheckbox = document.getElementById('removeImage');

        // Check if at least one field has been modified
        if (!fullName && !bio && !fileInput.files.length && !(removeCheckbox && removeCheckbox.checked)) {
            e.preventDefault();
            alert('Please make at least one change before saving.');
            return false;
        }

        return true;
    });
</script>
</body>
</html>

