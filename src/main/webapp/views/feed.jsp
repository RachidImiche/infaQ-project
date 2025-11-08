<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.donations.model.Post" %>
<%@ page import="com.donations.model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feed - DonationsApp</title>
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

        /* Navigation Bar */
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

        .navbar-search {
            flex: 1;
            max-width: 500px;
            margin: 0 30px;
        }

        .search-form {
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 10px 40px 10px 15px;
            border: 1px solid #ddd;
            border-radius: 25px;
            font-size: 14px;
            background: #f0f2f5;
        }

        .search-input:focus {
            outline: none;
            background: white;
            border-color: #667eea;
        }

        .search-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
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
            border-radius: 8px;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .nav-link:hover {
            background: #f0f2f5;
        }

        .btn-create {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.3s;
        }

        .btn-create:hover {
            transform: translateY(-2px);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        /* Main Content */
        .container {
            max-width: 680px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Category Filter */
        .category-filter {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .category-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .category-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .category-btn {
            padding: 8px 16px;
            border: 2px solid #ddd;
            border-radius: 20px;
            background: white;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
        }

        .category-btn:hover {
            border-color: #667eea;
            color: #667eea;
        }

        .category-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        /* Post Card */
        .post-card {
            background: white;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .post-header {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .post-author-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
        }

        .post-author-info {
            flex: 1;
        }

        .post-author-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 2px;
        }

        .post-date {
            font-size: 13px;
            color: #666;
        }

        .post-category-badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
            background: #e3f2fd;
            color: #1976d2;
        }

        .post-image {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
        }

        .post-content {
            padding: 20px;
        }

        .post-title {
            font-size: 1.5em;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .post-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .post-progress {
            background: #f0f2f5;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .progress-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .progress-label {
            color: #666;
            font-size: 14px;
        }

        .progress-value {
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #ddd;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 10px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50 0%, #45a049 100%);
            transition: width 0.5s;
        }

        .post-stats {
            display: flex;
            gap: 25px;
            padding: 10px 20px;
            border-top: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
            font-size: 14px;
            color: #666;
        }

        .post-actions {
            display: flex;
            padding: 5px 10px;
        }

        .action-btn {
            flex: 1;
            padding: 10px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 15px;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .action-btn:hover {
            background: #f0f2f5;
        }

        .action-btn.liked {
            color: #e74c3c;
        }

        .action-btn-form {
            flex: 1;
            margin: 0;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .empty-state-icon {
            font-size: 4em;
            margin-bottom: 20px;
        }

        .empty-state h2 {
            color: #666;
            margin-bottom: 10px;
        }
        .post-author-name:hover {
            color: #667eea !important;
        }

        .post-author-avatar:hover {
            transform: scale(1.05);
            transition: transform 0.3s;
        }

        .post-author-name:hover {
            color: #667eea !important;
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

    List<Post> posts = (List<Post>) request.getAttribute("posts");
    Map<Long, Boolean> likedPosts = (Map<Long, Boolean>) request.getAttribute("likedPosts");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String searchQuery = (String) request.getAttribute("searchQuery");

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a");
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            <span>🎁</span> DonationsApp
        </a>

        <div class="navbar-search">
            <form method="GET" action="<%= request.getContextPath() %>/feed" class="search-form">
                <input type="text" name="search" class="search-input"
                       placeholder="Search donation posts..."
                       value="<%= searchQuery != null ? searchQuery : "" %>">
                <button type="submit" class="search-btn">🔍</button>
            </form>
        </div>


        <div class="navbar-menu">
            <a href="<%= request.getContextPath() %>/posts/create" class="btn-create">
                ➕ Create Post
            </a>
            <div class="user-profile">
                <div class="user-avatar">
                    <%= currentUser.getUsername().substring(0, 1).toUpperCase() %>
                </div>
                <a href="<%= request.getContextPath() %>/profile" class="nav-link">
                    👤 Profile
                </a>
                <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <!-- Category Filter -->
    <div class="category-filter">
        <div class="category-title">Filter by Category</div>
        <div class="category-buttons">
            <a href="<%= request.getContextPath() %>/feed"
               class="category-btn <%= selectedCategory == null ? "active" : "" %>">
                All
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Education"
               class="category-btn <%= "Education".equals(selectedCategory) ? "active" : "" %>">
                📚 Education
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Healthcare"
               class="category-btn <%= "Healthcare".equals(selectedCategory) ? "active" : "" %>">
                🏥 Healthcare
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Environment"
               class="category-btn <%= "Environment".equals(selectedCategory) ? "active" : "" %>">
                🌱 Environment
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Poverty Relief"
               class="category-btn <%= "Poverty Relief".equals(selectedCategory) ? "active" : "" %>">
                🤝 Poverty Relief
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Disaster Relief"
               class="category-btn <%= "Disaster Relief".equals(selectedCategory) ? "active" : "" %>">
                🆘 Disaster Relief
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Animal Welfare"
               class="category-btn <%= "Animal Welfare".equals(selectedCategory) ? "active" : "" %>">
                🐾 Animal Welfare
            </a>
        </div>
    </div>

    <!-- Posts Feed -->
    <%
        if (posts == null || posts.isEmpty()) {
    %>
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h2>No posts found</h2>
        <p>Be the first to create a donation post!</p>
    </div>
    <%
    } else {
        for (Post post : posts) {
            double progress = 0;
            if (post.getGoalAmount().doubleValue() > 0) {
                progress = (post.getCollectedAmount().doubleValue() / post.getGoalAmount().doubleValue()) * 100;
                if (progress > 100) progress = 100;
            }

            boolean isLiked = likedPosts.get(post.getId()) != null && likedPosts.get(post.getId());
    %>
    <div class="post-card">
        <!-- Post Header -->
        <div class="post-header">
            <div class="post-author-avatar">
                <%= post.getAuthor().getUsername().substring(0, 1).toUpperCase() %>
            </div>
            <div class="post-author-info">
                <a href="<%= request.getContextPath() %>/profile?username=<%= post.getAuthor().getUsername() %>"
                   style="text-decoration: none;">
                    <div class="post-author-name" style="cursor: pointer; transition: color 0.3s;">
                        <%= post.getAuthor().getUsername() %>
                    </div>
                </a>
                <div class="post-date"><%= post.getCreatedAt().format(formatter) %></div>
            </div>
            <div class="post-category-badge"><%= post.getCategory() %></div>
        </div>

        <!-- Post Image -->
        <%
            if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) {
        %>
        <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
             alt="<%= post.getTitle() %>" class="post-image">
        <%
            }
        %>

        <!-- Post Content -->
        <div class="post-content">
            <h2 class="post-title"><%= post.getTitle() %></h2>
            <p class="post-description"><%= post.getDescription() %></p>

            <div class="post-progress">
                <div class="progress-row">
                    <span class="progress-label">Raised</span>
                    <span class="progress-value">$<%= String.format("%.2f", post.getCollectedAmount()) %></span>
                </div>
                <div class="progress-row">
                    <span class="progress-label">Goal</span>
                    <span class="progress-value">$<%= String.format("%.2f", post.getGoalAmount()) %></span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: <%= progress %>%"></div>
                </div>
            </div>
        </div>

        <!-- Post Stats -->
        <div class="post-stats">
            <span>❤️ <%= post.getLikesCount() %> likes</span>
            <span>💬 <%= post.getCommentsCount() %> comments</span>
            <span>🎁 <%= post.getDonationsCount() %> donations</span>
        </div>

        <!-- Post Actions -->
        <div class="post-actions">
            <form method="POST"
                  action="<%= request.getContextPath() %>/posts/like"
                  class="action-btn-form">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <input type="hidden" name="action" value="<%= isLiked ? "unlike" : "like" %>">
                <button type="submit" class="action-btn <%= isLiked ? "liked" : "" %>">
                    <%= isLiked ? "❤️" : "🤍" %> <%= isLiked ? "Liked" : "Like" %>
                </button>
            </form>

            <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
               class="action-btn">
                💬 Comment
            </a>

            <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
               class="action-btn">
                🎁 Donate
            </a>
        </div>

        <%
            if (post.getAuthor().getId().equals(currentUser.getId())) {
        %>
        <div style="padding: 10px 20px; border-top: 1px solid #e0e0e0; display: flex; gap: 10px;">
            <a href="<%= request.getContextPath() %>/posts/edit?id=<%= post.getId() %>"
               style="flex: 1; padding: 10px; text-align: center; background: #ff9800; color: white; text-decoration: none; border-radius: 5px; font-weight: 500;">
                ✏️ Edit Post
            </a>
            <form method="POST" action="<%= request.getContextPath() %>/posts/delete"
                  onsubmit="return confirm('Are you sure you want to delete this post? This action cannot be undone.');"
                  style="flex: 1; margin: 0;">
                <input type="hidden" name="id" value="<%= post.getId() %>">
                <button type="submit" style="width: 100%; padding: 10px; background: #f44336; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: 500;">
                    🗑️ Delete Post
                </button>
            </form>
        </div>
        <%
            }
        %>
    </div>
    <%
            }
        }
    %>
</div>
</body>
</html>