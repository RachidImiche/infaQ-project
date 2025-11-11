package com.donations.controller;

import com.donations.dao.LikeDAO;
import com.donations.dao.SavedPostDAO;
import com.donations.model.SavedPost;
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

@WebServlet("/saved")
public class SavedPostsServlet extends HttpServlet {

    private SavedPostDAO savedPostDAO;
    private LikeDAO likeDAO;

    @Override
    public void init() {
        savedPostDAO = new SavedPostDAO();
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

        // Get all saved posts for the user
        List<SavedPost> savedPosts = savedPostDAO.getSavedPostsByUser(currentUser.getId());

        // Check which posts the user has liked
        Map<Long, Boolean> likedPosts = new HashMap<>();
        if (savedPosts != null) {
            for (SavedPost savedPost : savedPosts) {
                boolean liked = likeDAO.hasUserLikedPost(currentUser.getId(), savedPost.getPost().getId());
                likedPosts.put(savedPost.getPost().getId(), liked);
            }
        }

        request.setAttribute("savedPosts", savedPosts);
        request.setAttribute("likedPosts", likedPosts);

        request.getRequestDispatcher("/views/saved-posts.jsp").forward(request, response);
    }
}

