package com.donations.controller;

import com.donations.dao.LikeDAO;
import com.donations.dao.PostDAO;
import com.donations.model.Post;
import com.donations.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/feed")
public class PostFeedServlet extends HttpServlet {

    private PostDAO postDAO;
    private LikeDAO likeDAO;

    @Override
    public void init() {
        postDAO = new PostDAO();
        likeDAO = new LikeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String category = request.getParameter("category");
        String search = request.getParameter("search");

        List<Post> posts;
        if (search != null && !search.trim().isEmpty()) {
            posts = postDAO.searchPosts(search);
        } else if (category != null && !category.trim().isEmpty()) {
            posts = postDAO.getPostsByCategory(category);
        } else {
            posts = postDAO.getAllPosts();
        }

        // Check which posts the user has liked
        Map<Long, Boolean> likedPosts = new HashMap<>();
        if (posts != null) {
            for (Post post : posts) {
                boolean liked = likeDAO.hasUserLikedPost(currentUser.getId(), post.getId());
                likedPosts.put(post.getId(), liked);
            }
        }

        request.setAttribute("posts", posts);
        request.setAttribute("likedPosts", likedPosts);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("searchQuery", search);

        request.getRequestDispatcher("/views/feed.jsp").forward(request, response);
    }
}