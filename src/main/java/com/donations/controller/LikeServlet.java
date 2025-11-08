package com.donations.controller;

import com.donations.dao.LikeDAO;
import com.donations.dao.PostDAO;
import com.donations.model.Like;
import com.donations.model.Post;
import com.donations.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/posts/like")
public class LikeServlet extends HttpServlet {

    private LikeDAO likeDAO;
    private PostDAO postDAO;

    @Override
    public void init() {
        likeDAO = new LikeDAO();
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

        if ("like".equals(action)) {
            // Add like
            if (!likeDAO.hasUserLikedPost(currentUser.getId(), postId)) {
                Like like = new Like(currentUser, post);
                likeDAO.saveLike(like);
            }
        } else if ("unlike".equals(action)) {
            // Remove like
            likeDAO.deleteLike(currentUser.getId(), postId);
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