package com.donations.controller;

import com.donations.dao.PostDAO;
import com.donations.dao.SavedPostDAO;
import com.donations.model.Post;
import com.donations.model.SavedPost;
import com.donations.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/posts/save")
public class SavePostServlet extends HttpServlet {

    private SavedPostDAO savedPostDAO;
    private PostDAO postDAO;

    @Override
    public void init() {
        savedPostDAO = new SavedPostDAO();
        postDAO = new PostDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String postIdParam = request.getParameter("postId");
        String action = request.getParameter("action");

        if (postIdParam == null || postIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Long postId = Long.parseLong(postIdParam);
        Post post = postDAO.getPostById(postId);

        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        if ("save".equals(action)) {
            // Add to saved posts
            if (!savedPostDAO.hasUserSavedPost(currentUser.getId(), postId)) {
                SavedPost savedPost = new SavedPost(currentUser, post);
                savedPostDAO.saveSavedPost(savedPost);
            }
        } else if ("unsave".equals(action)) {
            // Remove from saved posts
            savedPostDAO.deleteSavedPost(currentUser.getId(), postId);
        }

        // Redirect back to the referring page
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/feed");
        }
    }
}

