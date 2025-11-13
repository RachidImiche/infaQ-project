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
    <title>Trending - infaQ</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            text-decoration: none;
            color: #333;
            font-size: 1.8em;
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
            padding: 10px 18px;
            border-radius: 4px;
            transition: all 0.3s;
            font-weight: normal;
        }

        .nav-link:hover {
            background: #f0f0f0;
        }

        .nav-link.active {
            background: #333;
            color: white;
        }

        .btn-create {
            background: #333;
            color: white;
            padding: 10px 20px;
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
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 16px;
        }

        .profile-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #666;
            font-weight: bold;
            font-size: 16px;
            color: white;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Hero Section */
        .hero-section {
            padding: 60px 30px 40px;
            text-align: center;
            background: white;
            border-bottom: 1px solid #ddd;
        }

        .hero-title {
            font-size: 3em;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .hero-subtitle {
            font-size: 1.3em;
            color: #666;
            margin-bottom: 10px;
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 30px 60px;
        }

        /* Trending Grid - 2 columns */
        .trending-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }

        @media (max-width: 1024px) {
            .trending-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Trending Post Card */
        .trending-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            transition: all 0.3s;
            position: relative;
        }

        .trending-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        /* Trending Badge */
        .trending-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #f44336;
            color: white;
            padding: 8px 16px;
            border-radius: 3px;
            font-weight: bold;
            font-size: 14px;
            z-index: 10;
        }

        .rank-badge {
            position: absolute;
            top: 20px;
            left: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #ffd700;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 22px;
            border: 3px solid white;
            z-index: 10;
        }

        .rank-badge.rank-1 {
            background: #ffd700;
        }

        .rank-badge.rank-2 {
            background: #c0c0c0;
        }

        .rank-badge.rank-3 {
            background: #cd7f32;
        }

        /* Image Section */
        .card-image-section {
            position: relative;
            height: 320px;
            overflow: hidden;
        }

        .card-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .no-image {
            width: 100%;
            height: 100%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4em;
            color: white;
        }

        .category-tag {
            position: absolute;
            bottom: 20px;
            left: 20px;
            padding: 8px 18px;
            border-radius: 3px;
            font-size: 13px;
            font-weight: bold;
            background: rgba(255, 255, 255, 0.95);
            color: #333;
            border: 1px solid #ddd;
        }

        /* Card Content */
        .card-content {
            padding: 30px;
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .author-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #666;
            color: white;
            font-weight: bold;
            font-size: 18px;
            flex-shrink: 0;
        }

        .author-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .author-info {
            flex: 1;
        }

        .author-name {
            font-weight: bold;
            color: #333;
            font-size: 16px;
            margin-bottom: 4px;
            text-decoration: none;
            display: block;
        }

        .author-name:hover {
            color: #555;
        }

        .post-date {
            font-size: 13px;
            color: #999;
        }

        .card-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.3;
            cursor: pointer;
        }

        .card-title:hover {
            color: #555;
        }

        .card-description {
            color: #666;
            line-height: 1.7;
            margin-bottom: 25px;
            font-size: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Progress Section */
        .progress-section {
            background: #f9f9f9;
            padding: 25px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
        }

        .progress-amounts {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .amount-item {
            text-align: center;
        }

        .amount-label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .amount-value {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }

        .amount-value.goal {
            color: #333;
        }

        .progress-bar-container {
            width: 100%;
            height: 12px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: #4CAF50;
            border-radius: 4px;
        }

        .progress-percentage {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
            color: #4CAF50;
            font-size: 16px;
        }

        /* Stats Section */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 25px;
        }

        .stat-item {
            text-align: center;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
        }

        .stat-value {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 3px;
        }

        .stat-label {
            font-size: 11px;
            color: #666;
            text-transform: uppercase;
            font-weight: bold;
        }

        /* Actions */
        .card-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: normal;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-view {
            background: #333;
            color: white;
            text-decoration: none;
        }

        .btn-view:hover {
            background: #555;
        }

        .btn-like {
            background: #f9f9f9;
            color: #666;
            border: 1px solid #e0e0e0;
        }

        .btn-like.liked {
            background: #ffebee;
            color: #e74c3c;
            border-color: #e74c3c;
        }

        .btn-like:hover {
            background: #f0f0f0;
        }

        .btn-save {
            background: #f9f9f9;
            color: #666;
            border: 1px solid #e0e0e0;
        }

        .btn-save.saved {
            background: #e3f2fd;
            color: #333;
            border-color: #333;
        }

        .btn-save:hover {
            background: #f0f0f0;
        }

        .action-btn-form {
            flex: 1;
            margin: 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 100px 20px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .empty-icon {
            font-size: 5em;
            margin-bottom: 30px;
            opacity: 0.6;
            color: #999;
        }

        .empty-title {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .empty-message {
            font-size: 1.2em;
            color: #666;
            margin-bottom: 35px;
        }

        .btn-primary {
            display: inline-block;
            background: #333;
            color: white;
            padding: 15px 40px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: normal;
            font-size: 16px;
        }

        .btn-primary:hover {
            background: #555;
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

    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
%>

<!-- Navigation -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>

        <div class="navbar-menu">
            <a href="<%= request.getContextPath() %>/feed" class="nav-link">
                Home
            </a>
            <a href="<%= request.getContextPath() %>/trending" class="nav-link active">
                Trending
            </a>
            <a href="<%= request.getContextPath() %>/saved" class="nav-link">
                Saved
            </a>
            <a href="<%= request.getContextPath() %>/posts/create" class="btn-create">
                Create Post
            </a>

            <div class="user-profile">
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

<!-- Hero Section -->
<div class="hero-section">
    <h1 class="hero-title">Trending Posts</h1>
    <p class="hero-subtitle">Most viewed and popular campaigns right now</p>
</div>

<!-- Main Content -->
<div class="container">
    <% if (posts == null || posts.isEmpty()) { %>
    <div class="empty-state">
        <div class="empty-icon">No trending posts</div>
        <h2 class="empty-title">No Trending Posts Yet</h2>
        <p class="empty-message">Be the first to create a viral campaign!</p>
        <a href="<%= request.getContextPath() %>/posts/create" class="btn-primary">
            Create First Post
        </a>
    </div>
    <% } else { %>
    <div class="trending-grid">
        <%
            int rank = 1;
            for (Post post : posts) {
                User author = post.getAuthor();
                String authorInitial = author.getUsername().substring(0, 1).toUpperCase();
                boolean isLiked = likedPosts.getOrDefault(post.getId(), false);
                boolean isSaved = savedPosts.getOrDefault(post.getId(), false);

                double progress = 0;
                if (post.getGoalAmount().doubleValue() > 0) {
                    progress = (post.getCollectedAmount().doubleValue() / post.getGoalAmount().doubleValue()) * 100;
                    if (progress > 100) progress = 100;
                }

                String rankClass = rank <= 3 ? "rank-" + rank : "";
        %>
        <div class="trending-card">
            <div class="rank-badge <%= rankClass %>">#<%= rank %></div>
            <div class="trending-badge">
                TRENDING
            </div>

            <div class="card-image-section">
                <% if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) { %>
                <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
                     alt="<%= post.getTitle() %>"
                     class="card-image">
                <% } else { %>
                <div class="no-image">No Image</div>
                <% } %>

                <% if (post.getCategory() != null && !post.getCategory().isEmpty()) { %>
                <div class="category-tag"><%= post.getCategory() %></div>
                <% } %>
            </div>

            <div class="card-content">
                <div class="card-header">
                    <div class="author-avatar">
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
                    <div class="author-info">
                        <a href="<%= request.getContextPath() %>/profile?username=<%= author.getUsername() %>"
                           class="author-name">
                            <%= author.getUsername() %>
                        </a>
                        <% if (author.getFullName() != null && !author.getFullName().isEmpty()) { %>
                        <div style="font-size: 12px; color: #999;"><%= author.getFullName() %></div>
                        <% } %>
                        <div class="post-date"><%= post.getCreatedAt().format(dateFormatter) %></div>
                    </div>
                </div>

                <h2 class="card-title"
                    onclick="window.location.href='<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>'">
                    <%= post.getTitle() %>
                </h2>

                <% if (post.getDescription() != null && !post.getDescription().isEmpty()) { %>
                <p class="card-description"><%= post.getDescription() %></p>
                <% } %>

                <div class="progress-section">
                    <div class="progress-amounts">
                        <div class="amount-item">
                            <div class="amount-label">Raised</div>
                            <div class="amount-value">$<%= String.format("%.0f", post.getCollectedAmount()) %></div>
                        </div>
                        <div class="amount-item">
                            <div class="amount-label">Goal</div>
                            <div class="amount-value goal">$<%= String.format("%.0f", post.getGoalAmount()) %></div>
                        </div>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: <%= progress %>%"></div>
                    </div>
                    <div class="progress-percentage"><%= String.format("%.0f", progress) %>% funded</div>
                </div>

                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-value"><%= post.getViewCount() %></div>
                        <div class="stat-label">Views</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%= post.getLikesCount() %></div>
                        <div class="stat-label">Likes</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%= post.getCommentsCount() %></div>
                        <div class="stat-label">Comments</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%= post.getDonationsCount() %></div>
                        <div class="stat-label">Donations</div>
                    </div>
                </div>

                <div class="card-actions">
                    <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
                       class="action-btn btn-view">
                        View Details
                    </a>

                    <form method="POST"
                          action="<%= request.getContextPath() %>/posts/like"
                          class="action-btn-form">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">
                        <input type="hidden" name="action" value="<%= isLiked ? "unlike" : "like" %>">
                        <button type="submit" class="action-btn btn-like <%= isLiked ? "liked" : "" %>">
                            <%= isLiked ? "Liked" : "Like" %>
                        </button>
                    </form>

                    <form method="POST"
                          action="<%= request.getContextPath() %>/posts/save"
                          class="action-btn-form">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">
                        <input type="hidden" name="action" value="<%= isSaved ? "unsave" : "save" %>">
                        <button type="submit" class="action-btn btn-save <%= isSaved ? "saved" : "" %>">
                            <%= isSaved ? "Saved" : "Save" %>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%
                rank++;
            }
        %>
    </div>
    <% } %>
</div>
</body>
</html>