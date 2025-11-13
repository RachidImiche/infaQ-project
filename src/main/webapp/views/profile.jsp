<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.donations.model.User" %>
<%@ page import="com.donations.model.Post" %>
<%@ page import="com.donations.model.Donation" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - infaQ</title>
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .profile-header {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 40px;
            margin-bottom: 20px;
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 48px;
            flex-shrink: 0;
            overflow: hidden;
            border: 3px solid #ddd;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-details {
            flex: 1;
        }

        .profile-username {
            font-size: 2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .profile-fullname {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 8px;
        }

        .profile-bio {
            color: #666;
            line-height: 1.6;
            margin-top: 15px;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            padding-top: 30px;
            border-top: 1px solid #e0e0e0;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 0.95em;
        }

        .tabs {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .tab-buttons {
            display: flex;
            gap: 15px;
            border-bottom: 2px solid #e0e0e0;
        }

        .tab-button {
            padding: 12px 24px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            color: #666;
            transition: all 0.3s;
            margin-bottom: -2px;
        }

        .tab-button.active {
            color: #333;
            border-bottom-color: #333;
        }

        .tab-button:hover {
            color: #333;
        }

        .tab-content {
            display: none;
            padding-top: 20px;
        }

        .tab-content.active {
            display: block;
        }

        .post-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .post-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .post-thumbnail {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: #666;
        }

        .post-card-content {
            padding: 20px;
        }

        .post-card-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-card-category {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 3px;
            font-size: 12px;
            background: #f0f0f0;
            color: #333;
            margin-bottom: 10px;
            border: 1px solid #ddd;
        }

        .post-card-progress {
            margin-top: 15px;
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 8px;
        }

        .progress-fill {
            height: 100%;
            background: #4CAF50;
        }

        .progress-text {
            font-size: 14px;
            color: #666;
        }

        .progress-amount {
            font-weight: bold;
            color: #333;
        }

        .post-card-stats {
            display: flex;
            gap: 15px;
            margin-top: 12px;
            font-size: 14px;
            color: #666;
        }

        .donation-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .donation-item {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .donation-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #4CAF50;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            flex-shrink: 0;
        }

        .donation-details {
            flex: 1;
        }

        .donation-post-title {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .donation-date {
            font-size: 13px;
            color: #999;
        }

        .donation-amount {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-icon {
            font-size: 4em;
            margin-bottom: 15px;
        }

        .profile-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-edit-profile {
            padding: 10px 24px;
            background: #333;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: normal;
            text-decoration: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-edit-profile:hover {
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

    User profileUser = (User) request.getAttribute("profileUser");
    boolean isOwnProfile = (Boolean) request.getAttribute("isOwnProfile");
    List<Post> userPosts = (List<Post>) request.getAttribute("userPosts");
    List<Donation> userDonations = (List<Donation>) request.getAttribute("userDonations");

    int totalPosts = (Integer) request.getAttribute("totalPosts");
    BigDecimal totalRaised = (BigDecimal) request.getAttribute("totalRaised");
    BigDecimal totalGoal = (BigDecimal) request.getAttribute("totalGoal");
    int totalLikes = (Integer) request.getAttribute("totalLikes");
    int totalDonationsReceived = (Integer) request.getAttribute("totalDonationsReceived");
    BigDecimal totalDonated = (BigDecimal) request.getAttribute("totalDonated");

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
%>

<nav class="navbar">
    <div class="navbar-content">
        <a href="<%= request.getContextPath() %>/feed" class="navbar-brand">
            infaQ
        </a>
        <a href="<%= request.getContextPath() %>/feed" class="nav-link">Back to Feed</a>
    </div>
</nav>

<div class="container">
    <!-- Profile Header -->
    <div class="profile-header">

        <div class="profile-info">
            <div class="profile-avatar">
                <% if (profileUser.getProfileImage() != null && !profileUser.getProfileImage().isEmpty()) { %>
                <img src="<%= request.getContextPath() %>/<%= profileUser.getProfileImage() %>"
                     alt="<%= profileUser.getUsername() %>">
                <% } else { %>
                <%= profileUser.getUsername().substring(0, 1).toUpperCase() %>
                <% } %>
            </div>
            <div class="profile-details">
                <div class="profile-username">
                    @<%= profileUser.getUsername() %>
                    <% if (isOwnProfile) { %>
                    <span style="font-size: 0.5em; color: #666; font-weight: normal; margin-left: 10px;">
                    (You)
                </span>
                    <% } %>
                </div>
                <%
                    if (profileUser.getFullName() != null && !profileUser.getFullName().isEmpty()) {
                %>
                <div class="profile-fullname"><%= profileUser.getFullName() %></div>
                <%
                    }
                    if (profileUser.getBio() != null && !profileUser.getBio().isEmpty()) {
                %>
                <div class="profile-bio"><%= profileUser.getBio() %></div>
                <%
                } else if (!isOwnProfile) {
                %>
                <div class="profile-bio" style="color: #999; font-style: italic;">
                    This user hasn't added a bio yet.
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Profile Statistics -->
        <div class="profile-stats">
            <div class="stat-item">
                <div class="stat-value"><%= totalPosts %></div>
                <div class="stat-label">Posts</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">$<%= String.format("%.0f", totalRaised) %></div>
                <div class="stat-label">Total Raised</div>
            </div>
            <div class="stat-item">
                <div class="stat-value"><%= totalLikes %></div>
                <div class="stat-label">Total Likes</div>
            </div>
            <div class="stat-item">
                <div class="stat-value"><%= totalDonationsReceived %></div>
                <div class="stat-label">Donations Received</div>
            </div>
            <%
                if (isOwnProfile) {
            %>
            <div class="stat-item">
                <div class="stat-value">$<%= String.format("%.0f", totalDonated) %></div>
                <div class="stat-label">Total Donated</div>
            </div>
            <%
                }
            %>
        </div>

        <!-- Edit Profile Button (Only for own profile) -->
        <%
            if (isOwnProfile) {
        %>
        <div class="profile-actions">
            <a href="<%= request.getContextPath() %>/profile/edit" class="btn-edit-profile">
                Edit Profile
            </a>
        </div>
        <%
            }
        %>
    </div>

    <!-- Tabs -->
    <div class="tabs">
        <div class="tab-buttons">
            <button class="tab-button active" onclick="switchTab('posts')">
                Posts (<%= totalPosts %>)
            </button>
            <%
                if (isOwnProfile) {
            %>
            <button class="tab-button" onclick="switchTab('donations')">
                My Donations (<%= userDonations != null ? userDonations.size() : 0 %>)
            </button>
            <%
                }
            %>
        </div>

        <!-- Posts Tab -->
        <div id="posts-tab" class="tab-content active">
            <%
                if (userPosts != null && !userPosts.isEmpty()) {
            %>
            <div class="post-grid">
                <%
                    for (Post post : userPosts) {
                        double progress = 0;
                        if (post.getGoalAmount().doubleValue() > 0) {
                            progress = (post.getCollectedAmount().doubleValue() / post.getGoalAmount().doubleValue()) * 100;
                            if (progress > 100) progress = 100;
                        }
                %>
                <div class="post-card" onclick="window.location.href='<%= request.getContextPath() %>/posts/details?id=<%= post.getId() %>'">
                    <%
                        if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) {
                    %>
                    <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
                         alt="<%= post.getTitle() %>" class="post-thumbnail">
                    <%
                    } else {
                    %>
                    <div class="post-thumbnail" style="display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                        No Image
                    </div>
                    <%
                        }
                    %>
                    <div class="post-card-content">
                        <div class="post-card-category"><%= post.getCategory() %></div>
                        <div class="post-card-title"><%= post.getTitle() %></div>

                        <div class="post-card-progress">
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: <%= progress %>%"></div>
                            </div>
                            <div class="progress-text">
                                <span class="progress-amount">$<%= String.format("%.2f", post.getCollectedAmount()) %></span>
                                raised of $<%= String.format("%.2f", post.getGoalAmount()) %>
                            </div>
                        </div>

                        <div class="post-card-stats">
                            <span><%= post.getLikesCount() %> likes</span>
                            <span><%= post.getCommentsCount() %> comments</span>
                            <span><%= post.getDonationsCount() %> donations</span>
                            <span><%= post.getViewCount() %> views</span>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
            } else {
            %>

            <div class="empty-state">
                <div class="empty-icon">No posts</div>
                <h3><%= isOwnProfile ? "You haven't created any posts yet" : profileUser.getUsername() + " hasn't created any posts yet" %></h3>
                <%
                    if (isOwnProfile) {
                %>
                <p>Start making a difference by creating your first donation campaign!</p>
                <a href="<%= request.getContextPath() %>/posts/create"
                   style="display: inline-block; margin-top: 20px; padding: 12px 24px; background: #333; color: white; text-decoration: none; border-radius: 4px; font-weight: normal;">
                    Create Your First Post
                </a>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>

        <!-- Donations Tab (Only for own profile) -->
        <%
            if (isOwnProfile) {
        %>
        <div id="donations-tab" class="tab-content">
            <%
                if (userDonations != null && !userDonations.isEmpty()) {
            %>
            <div class="donation-list">
                <%
                    for (Donation donation : userDonations) {
                %>
                <div class="donation-item">
                    <div class="donation-icon">$</div>
                    <div class="donation-details">
                        <div class="donation-post-title"><%= donation.getPost().getTitle() %></div>
                        <div class="donation-date"><%= donation.getCreatedAt().format(formatter) %></div>
                        <%
                            if (donation.getMessage() != null && !donation.getMessage().isEmpty()) {
                        %>
                        <div style="color: #666; font-style: italic; margin-top: 5px; font-size: 14px;">
                            "<%= donation.getMessage() %>"
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="donation-amount">$<%= String.format("%.2f", donation.getAmount()) %></div>
                </div>
                <%
                    }
                %>
            </div>
            <%
            } else {
            %>
            <div class="empty-state">
                <div class="empty-icon">No donations</div>
                <h3>You haven't made any donations yet</h3>
                <p>Support meaningful causes and make an impact today!</p>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        %>
    </div>
</div>

<script>
    function switchTab(tabName) {
        // Hide all tabs
        const tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(tab => tab.classList.remove('active'));

        // Remove active from all buttons
        const buttons = document.querySelectorAll('.tab-button');
        buttons.forEach(button => button.classList.remove('active'));

        // Show selected tab
        document.getElementById(tabName + '-tab').classList.add('active');
        event.target.classList.add('active');
    }
</script>
</body>
</html>