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
    <title>Feed - infaQ</title>
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
            padding: 8px 80px 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-input:focus {
            outline: none;
            border-color: #666;
        }

        .search-btn {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            background: #333;
            color: white;
            border: none;
            padding: 4px 12px;
            cursor: pointer;
            font-size: 13px;
            border-radius: 3px;
        }

        .search-btn:hover {
            background: #555;
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

        .btn-create {
            background: #333;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: normal;
        }

        .btn-create:hover {
            background: #555;
        }


        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 14px;
            overflow: hidden; /* Ensures image stays within the circle */
        }*
                 .user-avatar:hover {
                     transform: scale(1.05);
                     transition: transform 0.3s;
                 }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Makes the image fill and crop properly */
            border-radius: 50%;
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
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .category-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 12px;
            font-weight: bold;
        }

        .category-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .category-btn {
            padding: 6px 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background: white;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
        }

        .category-btn:hover {
            border-color: #666;
            background: #f9f9f9;
        }

        .category-btn.active {
            background: #333;
            color: white;
            border-color: #333;
        }

        /* Post Card */
        .post-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .post-header {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        .post-author-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 16px;
            overflow: hidden;
        }

        .post-author-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }


        .post-author-info {
            flex: 1;
        }

        .post-author-name {
            font-weight: bold;
            color: #333;
            margin-bottom: 2px;
        }

        .post-date {
            font-size: 13px;
            color: #666;
        }

        .post-category-badge {
            padding: 4px 10px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: normal;
            background: #f0f0f0;
            color: #333;
            border: 1px solid #ddd;
        }

        .post-image {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
            border-bottom: 1px solid #f0f0f0;
        }

        .post-content {
            padding: 20px;
        }

        .post-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .post-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
            cursor: pointer;
        }

        .post-progress {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
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
            font-weight: bold;
            color: #333;
            font-size: 16px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 10px;
        }

        .progress-fill {
            height: 100%;
            background: #4CAF50;
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
            font-size: 14px;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border-radius: 4px;
            transition: background 0.3s;
        }

        .action-btn:hover {
            background: #f0f0f0;
        }

        .action-btn.liked {
            color: #e74c3c;
        }

        .action-btn.saved {
            color: #075df3;
        }

        .action-btn-form {
            flex: 1;
            margin: 0;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .empty-state-icon {
            font-size: 3em;
            margin-bottom: 20px;
            color: #999;
        }

        .empty-state h2 {
            color: #666;
            margin-bottom: 10px;
        }

        .post-author-name:hover {
            color: #555 !important;
        }

        .post-author-avatar:hover {
            transform: scale(1.05);
            transition: transform 0.3s;
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
    Map<Long, Boolean> savedPosts = (Map<Long, Boolean>) request.getAttribute("savedPosts");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String searchQuery = (String) request.getAttribute("searchQuery");

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a");
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>

        <div class="navbar-search">
            <form method="GET" action="<%= request.getContextPath() %>/feed" class="search-form">
                <input type="text" name="search" class="search-input"
                       placeholder="Search donation posts..."
                       value="<%= searchQuery != null ? searchQuery : "" %>">
                <button type="submit" class="search-btn">Search</button>
            </form>
        </div>


        <div class="navbar-menu">
            <a href="<%= request.getContextPath() %>/posts/create" class="btn-create">
                Create Post
            </a>
            <a href="<%= request.getContextPath() %>/trending" class="nav-link">
                Trending
            </a>
            <a href="<%= request.getContextPath() %>/saved" class="nav-link">
                Saved
            </a>

            <div class="user-profile">
                <div class="user-avatar">
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
                <a href="<%= request.getContextPath() %>/profile" class="nav-link">
                    Profile
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
                Education
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Healthcare"
               class="category-btn <%= "Healthcare".equals(selectedCategory) ? "active" : "" %>">
                Healthcare
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Environment"
               class="category-btn <%= "Environment".equals(selectedCategory) ? "active" : "" %>">
                Environment
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Poverty Relief"
               class="category-btn <%= "Poverty Relief".equals(selectedCategory) ? "active" : "" %>">
                Poverty Relief
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Disaster Relief"
               class="category-btn <%= "Disaster Relief".equals(selectedCategory) ? "active" : "" %>">
                Disaster Relief
            </a>
            <a href="<%= request.getContextPath() %>/feed?category=Animal Welfare"
               class="category-btn <%= "Animal Welfare".equals(selectedCategory) ? "active" : "" %>">
                Animal Welfare
            </a>
        </div>
    </div>

    <!-- Posts Feed -->
    <%
        if (posts == null || posts.isEmpty()) {
    %>
    <div class="empty-state">
        <div class="empty-state-icon">No posts</div>
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
            boolean isSaved = savedPosts.get(post.getId()) != null && savedPosts.get(post.getId());

    %>
    <div class="post-card">
        <!-- Post Header -->
        <div class="post-header">
            <a href="<%= request.getContextPath() %>/profile?username=<%= post.getAuthor().getUsername() %>"
               style="text-decoration: none; display: flex; align-items: center; gap: 15px; flex: 1;">
                <div class="post-author-avatar">
                    <%
                        if (post.getAuthor().getProfileImage() != null && !post.getAuthor().getProfileImage().isEmpty()) {
                    %>
                    <img src="<%= request.getContextPath() %>/<%= post.getAuthor().getProfileImage() %>"
                         alt="<%= post.getAuthor().getUsername() %>"
                         data-initial="<%= post.getAuthor().getUsername().substring(0,1).toUpperCase() %>"
                         onerror="this.style.display='none';this.parentElement.textContent=this.getAttribute('data-initial');">
                    <%
                    } else {
                    %>
                    <%= post.getAuthor().getUsername().substring(0, 1).toUpperCase() %>
                    <%
                        }
                    %>
                </div>
                <div class="post-author-info">

                    <div class="post-author-name" style="cursor: pointer; transition: color 0.3s;">
                        <%= post.getAuthor().getUsername() %>
                    </div>

                    <div class="post-date"><%= post.getCreatedAt().format(formatter) %>
                    </div>
                </div>
            </a>
            <div class="post-category-badge"><%= post.getCategory() %> </div>

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
            <h2 class="post-title" onclick="window.location.href='<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>'"><%= post.getTitle() %>
            </h2>
            <p class="post-description" onclick="window.location.href='<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>'"><%= post.getDescription() %>
            </p>

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
            <span><%= post.getLikesCount() %> likes</span>
            <span><%= post.getCommentsCount() %> comments</span>
            <span><%= post.getDonationsCount() %> donations</span>
            <span><%= post.getViewCount() %> views</span>
        </div>

        <!-- Post Actions -->
        <div class="post-actions">
            <form method="POST"
                  action="<%= request.getContextPath() %>/posts/like"
                  class="action-btn-form">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <input type="hidden" name="action" value="<%= isLiked ? "unlike" : "like" %>">
                <button type="submit" class="action-btn <%= isLiked ? "liked" : "" %>">
                    <%= isLiked ? "Liked" : "Like" %>
                </button>
            </form>

            <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
               class="action-btn">
                Comment
            </a>

            <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
               class="action-btn">
                Donate
            </a>

            <form method="POST"
                  action="<%= request.getContextPath() %>/posts/save"
                  class="action-btn-form">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <input type="hidden" name="action" value="<%= isSaved ? "unsave" : "save" %>">
                <button type="submit" class="action-btn <%= isSaved ? "saved" : "" %>">
                    <%= isSaved ? "Saved" : "Save" %>
                </button>
            </form>
        </div>


        <%
            if (post.getAuthor().getId().equals(currentUser.getId())) {
        %>
        <div style="padding: 10px 20px; border-top: 1px solid #e0e0e0; display: flex; gap: 10px;">
            <a href="<%= request.getContextPath() %>/posts/edit?id=<%= post.getId() %>"
               style="flex: 1; padding: 10px; text-align: center; background: #ff9800; color: white; text-decoration: none; border-radius: 4px; font-weight: normal;">
                Edit Post
            </a>
            <form method="POST" action="<%= request.getContextPath() %>/posts/delete"
                  onsubmit="return confirm('Are you sure you want to delete this post? This action cannot be undone.');"
                  style="flex: 1; margin: 0;">
                <input type="hidden" name="id" value="<%= post.getId() %>">
                <button type="submit"
                        style="width: 100%; padding: 10px; background: #f44336; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: normal;">
                    Delete Post
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