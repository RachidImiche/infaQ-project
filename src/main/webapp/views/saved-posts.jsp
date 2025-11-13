<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.donations.model.SavedPost" %>
<%@ page import="com.donations.model.Post" %>
<%@ page import="com.donations.model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saved - infaQ</title>
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

        .navbar-menu {
            display: flex;
            align-items: center;
            gap: 20px;
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

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eee;
            font-weight: bold;
            font-size: 18px;
            color: #555;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #666;
            font-size: 1.1em;
        }

        /* Grid Layout - 3 columns */
        .posts-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }

        @media (max-width: 1024px) {
            .posts-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .posts-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Post Card */
        .post-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .post-image-container {
            width: 100%;
            height: 220px;
            overflow: hidden;
            background: #f0f0f0;
            position: relative;
        }

        .post-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .no-image {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #666;
            color: white;
            font-size: 3em;
        }

        .post-category-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            padding: 6px 14px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: normal;
            background: rgba(255, 255, 255, 0.95);
            color: #333;
            border: 1px solid #ddd;
        }

        .post-content {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .post-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .post-author-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #666;
            color: white;
            font-weight: bold;
            font-size: 14px;
        }

        .post-author-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .post-author-info {
            flex: 1;
        }

        .post-author-name {
            font-weight: bold;
            color: #333;
            font-size: 14px;
            text-decoration: none;
        }

        .post-author-name:hover {
            color: #555;
        }

        .post-date {
            font-size: 12px;
            color: #999;
        }

        .post-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 12px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .post-title-link {
            color: inherit;
            text-decoration: none;
        }

        .post-title-link:hover {
            color: #555;
        }

        .post-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
            font-size: 14px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            flex: 1;
        }

        .post-progress {
            margin-bottom: 15px;
        }

        .progress-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .progress-amount {
            font-weight: bold;
            color: #4CAF50;
        }

        .progress-goal {
            color: #666;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #4CAF50;
            transition: width 0.3s;
        }

        .post-stats {
            display: flex;
            gap: 15px;
            padding: 12px 0;
            border-top: 1px solid #e0e0e0;
            font-size: 13px;
            color: #666;
            margin-bottom: 12px;
        }

        .post-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            flex: 1;
            padding: 10px;
            border: none;
            background: #f0f0f0;
            cursor: pointer;
            font-size: 14px;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            border-radius: 4px;
            transition: all 0.3s;
            font-weight: normal;
            text-decoration: none;
        }

        .action-btn:hover {
            background: #e0e0e0;
        }

        .action-btn.liked {
            color: #e74c3c;
        }

        .action-btn.saved {
            color: #333;
        }

        .action-btn-form {
            flex: 1;
            margin: 0;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .empty-icon {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.5;
            color: #999;
        }

        .empty-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .empty-message {
            color: #666;
            font-size: 1.1em;
            margin-bottom: 30px;
        }

        .btn-primary {
            display: inline-block;
            background: #333;
            color: white;
            padding: 12px 30px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: normal;
        }

        .btn-primary:hover {
            background: #555;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>

        <div class="navbar-menu">
            <a href="<%= request.getContextPath() %>/feed" class="nav-link">
                Feed
            </a>
            <a href="<%= request.getContextPath() %>/trending" class="nav-link">
                Trending
            </a>
            <a href="<%= request.getContextPath() %>/saved" class="nav-link" style="background: #f0f0f0;">
                Saved
            </a>
            <a href="<%= request.getContextPath() %>/posts/create" class="nav-link">
                Create
            </a>

            <div class="user-profile">
                <%
                    User currentUser = (User) session.getAttribute("user");
                %>
                <div class="profile-avatar">
                    <%
                        if (currentUser.getProfileImage() != null && !currentUser.getProfileImage().isEmpty()) {
                    %>
                    <img src="<%= request.getContextPath() %>/<%= currentUser.getProfileImage() %>"
                         alt="<%= currentUser.getUsername() %>"
                         data-initial="<%= currentUser.getUsername().substring(0,1).toUpperCase() %>"
                         onerror="this.style.display='none';this.parentElement.textContent=this.getAttribute('data-initial');">
                    <%
                    } else {
                    %>
                    <%= currentUser.getUsername().substring(0, 1).toUpperCase() %>
                    <%
                        }
                    %>
                </div>

                <div class="profile-links">
                    <a href="<%= request.getContextPath() %>/profile" class="nav-link">Profile</a>
                    <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="page-header">
        <h1 class="page-title">
            Saved Posts
        </h1>
        <p class="page-subtitle">Posts you've saved for later</p>
    </div>

    <%
        List<SavedPost> savedPosts = (List<SavedPost>) request.getAttribute("savedPosts");
        Map<Long, Boolean> likedPosts = (Map<Long, Boolean>) request.getAttribute("likedPosts");
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
    %>

    <% if (savedPosts == null || savedPosts.isEmpty()) { %>
    <div class="empty-state">
        <div class="empty-icon">No saved posts</div>
        <h2 class="empty-title">No saved posts yet</h2>
        <p class="empty-message">Start exploring and save posts that interest you!</p>
        <a href="<%= request.getContextPath() %>/feed" class="btn-primary">Explore Posts</a>
    </div>
    <% } else { %>
    <div class="posts-grid">
        <% for (SavedPost savedPost : savedPosts) {
            Post post = savedPost.getPost();
            User author = post.getAuthor();
            String authorInitial = author.getUsername().substring(0, 1).toUpperCase();
            boolean isLiked = likedPosts.getOrDefault(post.getId(), false);

            double progress = 0;
            if (post.getGoalAmount().doubleValue() > 0) {
                progress = (post.getCollectedAmount().doubleValue() / post.getGoalAmount().doubleValue()) * 100;
                if (progress > 100) progress = 100;
            }
        %>
        <div class="post-card">
            <div class="post-image-container">
                <% if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) { %>
                <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
                     alt="<%= post.getTitle() %>"
                     class="post-image">
                <% } else { %>
                <div class="no-image">No Image</div>
                <% } %>

                <% if (post.getCategory() != null && !post.getCategory().isEmpty()) { %>
                <span class="post-category-badge"><%= post.getCategory() %></span>
                <% } %>
            </div>

            <div class="post-content">
                <div class="post-header">
                    <div class="post-author-avatar">
                        <a href="<%= request.getContextPath() %>/profile?username=<%= author.getUsername() %>" style="text-decoration: none; color: inherit; display: flex; width:100%; height:100%; align-items:center; justify-content:center;">
                            <%
                                String authorProfileImage = author.getProfileImage();
                                if (authorProfileImage != null && !authorProfileImage.isEmpty()) {
                            %>
                            <img src="<%= request.getContextPath() %>/<%= authorProfileImage %>"
                                 alt="<%= author.getUsername() %>"
                                 data-initial="<%= authorInitial %>"
                                 onerror="this.style.display='none';this.parentElement.textContent=this.getAttribute('data-initial');">
                            <%
                            } else {
                            %>
                            <%= authorInitial %>
                            <%
                                }
                            %>
                        </a>
                    </div>
                    <div class="post-author-info">
                        <a href="<%= request.getContextPath() %>/profile?username=<%= author.getUsername() %>"
                           class="post-author-name">
                            <%= author.getUsername() %>
                        </a>
                        <% if (author.getFullName() != null && !author.getFullName().isEmpty()) { %>
                        <div style="font-size: 11px; color: #999;"><%= author.getFullName() %></div>
                        <% } %>
                        <div class="post-date">
                            Saved <%= savedPost.getSavedAt().format(dateFormatter) %>
                        </div>
                    </div>
                </div>

                <h2 class="post-title">
                    <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
                       class="post-title-link">
                        <%= post.getTitle() %>
                    </a>
                </h2>

                <% if (post.getDescription() != null && !post.getDescription().isEmpty()) { %>
                <p class="post-description"><%= post.getDescription() %></p>
                <% } %>

                <div class="post-progress">
                    <div class="progress-info">
                        <span class="progress-amount">$<%= String.format("%.2f", post.getCollectedAmount()) %></span>
                        <span class="progress-goal">of $<%= String.format("%.2f", post.getGoalAmount()) %></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= progress %>%"></div>
                    </div>
                </div>

                <div class="post-stats">
                    <span><%= post.getLikesCount() %> likes</span>
                    <span><%= post.getCommentsCount() %> comments</span>
                    <span><%= post.getViewCount() %> views</span>
                </div>

                <div class="post-actions">
                    <form action="<%= request.getContextPath() %>/posts/like" method="post" class="action-btn-form">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">
                        <input type="hidden" name="action" value="<%= isLiked ? "unlike" : "like" %>">
                        <button type="submit" class="action-btn <%= isLiked ? "liked" : "" %>">
                            <%= isLiked ? "Liked" : "Like" %>
                        </button>
                    </form>

                    <form action="<%= request.getContextPath() %>/posts/save" method="post" class="action-btn-form">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">
                        <input type="hidden" name="action" value="unsave">
                        <button type="submit" class="action-btn saved">
                            Unsave
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>
</body>
</html>