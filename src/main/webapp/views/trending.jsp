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
    <title>Trending - DonationsApp</title>
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
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
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
            display: flex;
            align-items: center;
            gap: 10px;
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
            border-radius: 10px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .nav-link:hover {
            background: #f0f2f5;
            transform: translateY(-2px);
        }

        .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
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
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        }

        .hero-title {
            font-size: 3.5em;
            font-weight: 800;
            color: white;
            margin-bottom: 15px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.2);
            animation: fadeInDown 0.6s ease-out;
        }

        .hero-subtitle {
            font-size: 1.3em;
            color: rgba(255,255,255,0.95);
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .hero-emoji {
            font-size: 4em;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px 60px;
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
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            animation: fadeInUp 0.6s ease-out backwards;
        }

        .trending-card:nth-child(1) { animation-delay: 0.1s; }
        .trending-card:nth-child(2) { animation-delay: 0.2s; }
        .trending-card:nth-child(3) { animation-delay: 0.3s; }
        .trending-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .trending-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 60px rgba(0,0,0,0.25);
        }

        /* Trending Badge */
        .trending-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);
            display: flex;
            align-items: center;
            gap: 6px;
            z-index: 10;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .rank-badge {
            position: absolute;
            top: 20px;
            left: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            font-size: 22px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.5);
            border: 3px solid white;
            z-index: 10;
        }

        .rank-badge.rank-1 {
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            box-shadow: 0 4px 20px rgba(255, 215, 0, 0.6);
        }

        .rank-badge.rank-2 {
            background: linear-gradient(135deg, #c0c0c0 0%, #e8e8e8 100%);
            box-shadow: 0 4px 20px rgba(192, 192, 192, 0.6);
        }

        .rank-badge.rank-3 {
            background: linear-gradient(135deg, #cd7f32 0%, #daa569 100%);
            box-shadow: 0 4px 20px rgba(205, 127, 50, 0.6);
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
            transition: transform 0.6s;
        }

        .trending-card:hover .card-image {
            transform: scale(1.1);
        }

        .no-image {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 6em;
        }

        .category-tag {
            position: absolute;
            bottom: 20px;
            left: 20px;
            padding: 8px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            background: rgba(255, 255, 255, 0.95);
            color: #667eea;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            font-weight: 700;
            color: #333;
            font-size: 16px;
            margin-bottom: 4px;
            text-decoration: none;
            display: block;
            transition: color 0.3s;
        }

        .author-name:hover {
            color: #667eea;
        }

        .post-date {
            font-size: 13px;
            color: #999;
        }

        .card-title {
            font-size: 1.8em;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.3;
            cursor: pointer;
            transition: color 0.3s;
        }

        .card-title:hover {
            color: #667eea;
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
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
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
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .amount-value {
            font-size: 24px;
            font-weight: 800;
            color: #4CAF50;
        }

        .amount-value.goal {
            color: #667eea;
        }

        .progress-bar-container {
            width: 100%;
            height: 12px;
            background: rgba(255,255,255,0.8);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50 0%, #8BC34A 100%);
            border-radius: 10px;
            transition: width 1s ease-out;
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.4);
        }

        .progress-percentage {
            text-align: center;
            margin-top: 10px;
            font-weight: 700;
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
            background: #f8f9fa;
            border-radius: 12px;
            transition: all 0.3s;
        }

        .stat-item:hover {
            background: #e9ecef;
            transform: translateY(-3px);
        }

        .stat-icon {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 20px;
            font-weight: 700;
            color: #333;
            margin-bottom: 3px;
        }

        .stat-label {
            font-size: 11px;
            color: #666;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
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
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-view {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
        }

        .btn-view:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-like {
            background: #f8f9fa;
            color: #666;
        }

        .btn-like.liked {
            background: #ffebee;
            color: #e74c3c;
        }

        .btn-like:hover {
            background: #e9ecef;
        }

        .btn-save {
            background: #f8f9fa;
            color: #666;
        }

        .btn-save.saved {
            background: #e3f2fd;
            color: #667eea;
        }

        .btn-save:hover {
            background: #e9ecef;
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
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .empty-icon {
            font-size: 6em;
            margin-bottom: 30px;
            opacity: 0.6;
        }

        .empty-title {
            font-size: 2.5em;
            font-weight: 700;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 40px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 16px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
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
            <span>💝</span>
            <span>InfaQ</span>
        </a>

        <div class="navbar-menu">
            <a href="<%= request.getContextPath() %>/feed" class="nav-link">
                🏠 Home
            </a>
            <a href="<%= request.getContextPath() %>/trending" class="nav-link active">
                🔥 Trending
            </a>
            <a href="<%= request.getContextPath() %>/saved" class="nav-link">
                🔖 Saved
            </a>
            <a href="<%= request.getContextPath() %>/posts/create" class="btn-create">
                ➕ Create Post
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
    <div class="hero-emoji">🔥</div>
    <h1 class="hero-title">Trending Posts</h1>
    <p class="hero-subtitle">Most viewed and popular campaigns right now</p>
</div>

<!-- Main Content -->
<div class="container">
    <% if (posts == null || posts.isEmpty()) { %>
        <div class="empty-state">
            <div class="empty-icon">📊</div>
            <h2 class="empty-title">No Trending Posts Yet</h2>
            <p class="empty-message">Be the first to create a viral campaign!</p>
            <a href="<%= request.getContextPath() %>/posts/create" class="btn-primary">
                ➕ Create First Post
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
                        <span>🔥</span>
                        <span>HOT</span>
                    </div>

                    <div class="card-image-section">
                        <% if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
                                 alt="<%= post.getTitle() %>"
                                 class="card-image">
                        <% } else { %>
                            <div class="no-image">💝</div>
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
                                <div class="stat-icon">👁️</div>
                                <div class="stat-value"><%= post.getViewCount() %></div>
                                <div class="stat-label">Views</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">❤️</div>
                                <div class="stat-value"><%= post.getLikesCount() %></div>
                                <div class="stat-label">Likes</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">💬</div>
                                <div class="stat-value"><%= post.getCommentsCount() %></div>
                                <div class="stat-label">Comments</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">🎁</div>
                                <div class="stat-value"><%= post.getDonationsCount() %></div>
                                <div class="stat-label">Donations</div>
                            </div>
                        </div>

                        <div class="card-actions">
                            <a href="<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>"
                               class="action-btn btn-view">
                                👁️ View Details
                            </a>

                            <form method="POST"
                                  action="<%= request.getContextPath() %>/posts/like"
                                  class="action-btn-form">
                                <input type="hidden" name="postId" value="<%= post.getId() %>">
                                <input type="hidden" name="action" value="<%= isLiked ? "unlike" : "like" %>">
                                <button type="submit" class="action-btn btn-like <%= isLiked ? "liked" : "" %>">
                                    <%= isLiked ? "❤️" : "🤍" %>
                                </button>
                            </form>

                            <form method="POST"
                                  action="<%= request.getContextPath() %>/posts/save"
                                  class="action-btn-form">
                                <input type="hidden" name="postId" value="<%= post.getId() %>">
                                <input type="hidden" name="action" value="<%= isSaved ? "unsave" : "save" %>">
                                <button type="submit" class="action-btn btn-save <%= isSaved ? "saved" : "" %>">
                                    <%= isSaved ? "🔖" : "📌" %>
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
