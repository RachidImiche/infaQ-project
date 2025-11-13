<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.donations.model.Post" %>
<%@ page import="com.donations.model.User" %>
<%@ page import="com.donations.model.Donation" %>
<%@ page import="com.donations.model.Comment" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Details - infaQ</title>
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

        .copy-link-btn {
            width: 100%;
            padding: 12px;
            background: #333;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: normal;
            cursor: pointer;
        }

        .copy-link-btn:hover {
            background: #555;
        }

        .post-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
            overflow: hidden;
        }

        .post-header {
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .post-author-name:hover,
        .donation-user a:hover,
        .comment-author a:hover {
            color: #555 !important;
        }


        .donation-avatar:hover,
        .comment-avatar:hover {
            transform: scale(1.05);
            transition: transform 0.3s;
        }

        .post-author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
            overflow: hidden;
        }

        .post-author-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            display: block;
        }

        .post-author-avatar:hover {
            transform: scale(1.05);
            transition: transform 0.3s;
        }


        .post-author-info {
            flex: 1;
        }

        .post-author-name {
            font-weight: bold;
            color: #333;
            font-size: 16px;
            margin-bottom: 3px;
        }

        .post-date {
            font-size: 13px;
            color: #666;
        }

        .post-category-badge {
            padding: 6px 14px;
            border-radius: 3px;
            font-size: 13px;
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
            padding: 25px;
        }

        .post-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.3;
        }

        .post-description {
            color: #444;
            line-height: 1.7;
            margin-bottom: 25px;
            font-size: 15px;
        }

        .post-progress {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
        }

        .progress-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .progress-label {
            color: #666;
            font-size: 14px;
        }

        .progress-value {
            font-weight: bold;
            color: #333;
            font-size: 18px;
        }

        .progress-bar {
            width: 100%;
            height: 10px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 12px;
        }

        .progress-fill {
            height: 100%;
            background: #4CAF50;
        }

        .post-stats {
            display: flex;
            gap: 30px;
            padding: 15px 25px;
            border-top: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
            font-size: 15px;
            color: #666;
        }

        .post-actions {
            display: flex;
            padding: 8px 15px;
        }

        .action-btn {
            flex: 1;
            padding: 12px;
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
            font-weight: normal;
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
            /*flex: 1;*/
            /*margin: 0;*/
        }

        .donation-section, .comments-section, .donations-section {
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 25px;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
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

        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
        }

        input[type="number"]:focus,
        textarea:focus {
            outline: none;
            border-color: #666;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-donate {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: normal;
            cursor: pointer;
        }

        .btn-donate:hover {
            background: #45a049;
        }

        .comment-form textarea {
            margin-bottom: 12px;
        }

        .btn-comment {
            padding: 10px 24px;
            background: #333;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: normal;
            cursor: pointer;
        }

        .btn-comment:hover {
            background: #555;
        }

        .comments-list {
            border-top: 1px solid #e0e0e0;
            padding-top: 20px;
        }

        .comment-item {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f0f2f5;
        }

        .comment-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
            margin-bottom: 0;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            flex-shrink: 0;
            overflow: hidden; /* ensures image stays inside circle */
        }

        .comment-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* makes image fit properly */
            border-radius: 50%;
            display: block;
        }


        .comment-content {
            flex: 1;
        }

        .comment-author {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .comment-date {
            font-size: 12px;
            color: #999;
            margin-left: 10px;
        }

        .comment-text {
            color: #444;
            line-height: 1.5;
        }

        .donation-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 4px;
            margin-bottom: 12px;
            border: 1px solid #e0e0e0;
        }

        .donation-item:last-child {
            margin-bottom: 0;
        }

        .donation-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #4CAF50;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
            flex-shrink: 0;
            overflow: hidden;
        }

        .donation-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            display: block;
        }


        .donation-info {
            flex: 1;
        }

        .donation-user {
            font-weight: bold;
            color: #333;
            margin-bottom: 3px;
        }

        .donation-message {
            color: #666;
            font-size: 14px;
            font-style: italic;
        }

        .donation-amount {
            font-size: 18px;
            font-weight: bold;
            color: #4CAF50;
        }

        .empty-message {
            text-align: center;
            padding: 40px 20px;
            color: #999;
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

    boolean hasLiked = (Boolean) request.getAttribute("hasLiked");
    boolean hasSaved = (Boolean) request.getAttribute("hasSaved");
    List<Donation> donations = (List<Donation>) request.getAttribute("donations");
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a");
    DateTimeFormatter shortFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");

    double progress = 0;
    if (post.getGoalAmount().doubleValue() > 0) {
        progress = (post.getCollectedAmount().doubleValue() / post.getGoalAmount().doubleValue()) * 100;
        if (progress > 100) progress = 100;
    }
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
    <div class="post-card">

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
                    <% if (post.getAuthor().getFullName() != null && !post.getAuthor().getFullName().isEmpty()) { %>
                    <div style="font-size: 12px; color: #999;"><%= post.getAuthor().getFullName() %></div>
                    <% } %>
                    <div class="post-date"><%= post.getCreatedAt().format(formatter) %></div>
                </div>
            </a>
            <div style="display: flex; align-items: center; gap: 10px;">
                <div class="post-category-badge"><%= post.getCategory() %></div>
                <button onclick="copyPostLink()"
                        style="background: none; border: none; font-size: 14px; cursor: pointer; padding: 5px; color: #333; text-decoration: underline;"
                        title="Copy link to post">
                    Copy Link
                </button>
            </div>

        </div>

        <%
            if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) {
        %>
        <img src="<%= request.getContextPath() %>/<%= post.getImageUrl() %>"
             alt="<%= post.getTitle() %>" class="post-image">
        <%
            }
        %>

        <div class="post-content">
            <h1 class="post-title"><%= post.getTitle() %></h1>
            <p class="post-description"><%= post.getDescription() %></p>

            <div class="post-progress">
                <div class="progress-row">
                    <span class="progress-label">Raised so far</span>
                    <span class="progress-value">$<%= String.format("%.2f", post.getCollectedAmount()) %></span>
                </div>
                <div class="progress-row">
                    <span class="progress-label">Funding goal</span>
                    <span class="progress-value">$<%= String.format("%.2f", post.getGoalAmount()) %></span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: <%= progress %>%"></div>
                </div>
            </div>
        </div>

        <div class="post-stats">
            <span><%= post.getLikesCount() %> likes</span>
            <span><%= post.getCommentsCount() %> comments</span>
            <span><%= post.getDonationsCount() %> donations</span>
            <span><%= post.getViewCount() %> views</span>
        </div>

        <div class="post-actions">
            <form method="POST"
                  action="<%= request.getContextPath() %>/posts/like"
                  class="action-btn-form">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <input type="hidden" name="action" value="<%= hasLiked ? "unlike" : "like" %>">
                <button type="submit" class="action-btn <%= hasLiked ? "liked" : "like" %>">
                    <%= hasLiked ? "Liked" : "Like" %>
                </button>
            </form>

            <form method="POST"
                  action="<%= request.getContextPath() %>/posts/save"
                  class="action-btn-form">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <input type="hidden" name="action" value="<%= hasSaved ? "unsave" : "save" %>">
                <button type="submit" class="action-btn <%= hasSaved ? "saved" : "save" %>">
                    <%= hasSaved ? "Saved" : "Save" %>
                </button>
            </form>
        </div>
        <div style="padding: 15px 20px; border-top: 1px solid #e0e0e0;">
            <button onclick="copyPostLink()" class="copy-link-btn">
                Copy Link to Post
            </button>
            <span id="copySuccess" style="display: none; color: #4CAF50; margin-left: 10px; font-weight: bold;">
                Link copied!
            </span>
        </div>

        <%
            if (post.getAuthor().getId().equals(currentUser.getId())) {
        %>
        <div style="padding: 15px 20px; border-top: 1px solid #e0e0e0; display: flex; gap: 15px;">
            <a href="<%= request.getContextPath() %>/posts/edit?id=<%= post.getId() %>"
               style="flex: 1; padding: 12px; text-align: center; background: #ff9800; color: white; text-decoration: none; border-radius: 4px; font-weight: normal;">
                Edit Post
            </a>
            <form method="POST" action="<%= request.getContextPath() %>/posts/delete"
                  onsubmit="return confirm('Are you sure you want to delete this post? This action cannot be undone.');"
                  style="flex: 1; margin: 0;">
                <input type="hidden" name="id" value="<%= post.getId() %>">
                <button type="submit" style="width: 100%; padding: 12px; background: #f44336; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: normal;">
                    Delete Post
                </button>
            </form>
        </div>
        <%
            }
        %>
    </div>

    <!-- Donation Form -->
    <div class="donation-section">
        <h2 class="section-title">Make a Donation</h2>
        <form method="POST" action="<%= request.getContextPath() %>/posts/donate">
            <input type="hidden" name="postId" value="<%= post.getId() %>">

            <div class="form-group">
                <label for="amount">Donation Amount ($) *</label>
                <input type="number" id="amount" name="amount"
                       step="0.01" min="1" required
                       placeholder="Enter amount">
            </div>

            <div class="form-group">
                <label for="message">Message (Optional)</label>
                <textarea id="message" name="message"
                          placeholder="Leave a supportive message..."></textarea>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="anonymous" name="anonymous">
                    <label for="anonymous" style="margin-bottom: 0;">Donate anonymously</label>
                </div>
            </div>

            <button type="submit" class="btn-donate">Donate Now</button>
        </form>
    </div>

    <!-- Recent Donations -->
    <div class="donations-section">
        <h2 class="section-title">Recent Donations (<%= donations != null ? donations.size() : 0 %>)</h2>
        <%
            if (donations != null && !donations.isEmpty()) {
                for (Donation donation : donations) {
        %>
        <div class="donation-item">
            <a href="<%= request.getContextPath() %>/profile?username=<%= donation.getUser().getUsername() %>"
               style="text-decoration: none;">
                <div class="donation-avatar" style="cursor: pointer;">
                    <%
                        if (donation.isAnonymous()) {
                    %>
                    ?
                    <%
                    } else if (donation.getUser().getProfileImage() != null && !donation.getUser().getProfileImage().isEmpty()) {
                    %>
                    <img src="<%= request.getContextPath() %>/<%= donation.getUser().getProfileImage() %>"
                         alt="<%= donation.getUser().getUsername() %>"
                         data-initial="<%= donation.getUser().getUsername().substring(0,1).toUpperCase() %>"
                         onerror="this.style.display='none';this.parentElement.textContent=this.getAttribute('data-initial');">
                    <%
                    } else {
                    %>
                    <%= donation.getUser().getUsername().substring(0, 1).toUpperCase() %>
                    <%
                        }
                    %>
                </div>
            </a>

            <div class="donation-info">
                <div class="donation-user">
                    <% if (!donation.isAnonymous()) { %>
                    <a href="<%= request.getContextPath() %>/profile?username=<%= donation.getUser().getUsername() %>"
                       style="text-decoration: none; color: #333; transition: color 0.3s;"
                       onmouseover="this.style.color='#555'"
                       onmouseout="this.style.color='#333'">
                        <%= donation.getUser().getUsername() %>
                    </a>
                    <% } else { %>
                    Anonymous
                    <% } %>
                    <span style="color: #999; font-size: 13px; font-weight: normal;">
                    - <%= donation.getCreatedAt().format(shortFormatter) %>
                </span>
                </div>
                <%
                    if (donation.getMessage() != null && !donation.getMessage().isEmpty()) {
                %>
                <div class="donation-message">"<%= donation.getMessage() %>"</div>
                <%
                    }
                %>
            </div>
            <div class="donation-amount">$<%= String.format("%.2f", donation.getAmount()) %></div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty-message">
            No donations yet. Be the first to support this cause!
        </div>
        <%
            }
        %>
    </div>

    <!-- Comments Section -->
    <div class="comments-section">
        <h2 class="section-title">Comments (<%= comments != null ? comments.size() : 0 %>)</h2>

        <!-- Comment Form -->
        <div class="comment-form">
            <form method="POST" action="<%= request.getContextPath() %>/posts/comment">
                <input type="hidden" name="postId" value="<%= post.getId() %>">
                <textarea name="content" placeholder="Write a comment..." required></textarea>
                <button type="submit" class="btn-comment">Post Comment</button>
            </form>
        </div>

        <!-- Comments List -->
        <%
            if (comments != null && !comments.isEmpty()) {
        %>
        <div class="comments-list">
            <%
                for (Comment comment : comments) {
            %>
            <div class="comment-item">
                <a href="<%= request.getContextPath() %>/profile?username=<%= comment.getUser().getUsername() %>"
                   style="text-decoration: none;">
                    <div class="comment-avatar" style="cursor: pointer;">
                        <%
                            if (comment.getUser().getProfileImage() != null && !comment.getUser().getProfileImage().isEmpty()) {
                        %>
                        <img src="<%= request.getContextPath() %>/<%= comment.getUser().getProfileImage() %>"
                             alt="<%= comment.getUser().getUsername() %>"
                             data-initial="<%= comment.getUser().getUsername().substring(0,1).toUpperCase() %>"
                             onerror="this.style.display='none';this.parentElement.textContent=this.getAttribute('data-initial');">
                        <%
                        } else {
                        %>
                        <%= comment.getUser().getUsername().substring(0, 1).toUpperCase() %>
                        <%
                            }
                        %>
                    </div>
                </a>

                <div class="comment-content">
                    <div class="comment-author">
                        <a href="<%= request.getContextPath() %>/profile?username=<%= comment.getUser().getUsername() %>"
                           style="text-decoration: none; color: #333; transition: color 0.3s;"
                           onmouseover="this.style.color='#555'"
                           onmouseout="this.style.color='#333'">
                            <%= comment.getUser().getUsername() %>
                        </a>
                        <span class="comment-date"><%= comment.getCreatedAt().format(shortFormatter) %></span>
                    </div>
                    <div class="comment-text"><%= comment.getContent() %></div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <%
        } else {
        %>
        <div class="empty-message">
            No comments yet. Be the first to comment!
        </div>
        <%
            }
        %>
    </div>
</div>
<script>
    function copyPostLink() {
        const postId = <%= post.getId() %>;
        const baseUrl = '<%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>';
        const postUrl = baseUrl + '/posts/details?id=' + postId;

        //using Clipboard API
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(postUrl).then(function () {
                showCopySuccess();
            }).catch(function (err) {
                alert('Failed to copy link: ' + err);
            });
        }
    }



    function showCopySuccess() {
        const successMsg = document.getElementById('copySuccess');
        const btn = document.querySelector('.copy-link-btn');

        successMsg.style.display = 'inline';
        btn.textContent = 'Copied!';

        setTimeout(function() {
            successMsg.style.display = 'none';
            btn.textContent = 'Copy Link to Post';
        }, 3000);
    }
</script>
</body>
</html>