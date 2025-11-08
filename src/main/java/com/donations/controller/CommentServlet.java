package com.donations.controller;

import com.donations.dao.CommentDAO;
import com.donations.dao.PostDAO;
import com.donations.model.Comment;
import com.donations.model.Post;
import com.donations.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/posts/comment")
public class CommentServlet extends HttpServlet {

    private CommentDAO commentDAO;
    private PostDAO postDAO;

    @Override
    public void init() {
        commentDAO = new CommentDAO();
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
        String content = request.getParameter("content");

        if (postIdParam == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Long postId = Long.parseLong(postIdParam);
        Post post = postDAO.getPostById(postId);

        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Comment comment = new Comment(currentUser, post, content);
        commentDAO.saveComment(comment);

        response.sendRedirect(request.getContextPath() + "/posts/details?id=" + postId);
    }
}