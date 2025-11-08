package com.donations.controller;

import com.donations.dao.PostDAO;
import com.donations.model.Post;
import com.donations.model.User;
import com.donations.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/posts/delete")
public class PostDeleteServlet extends HttpServlet {

    private PostDAO postDAO;

    @Override
    public void init() {
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
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Long id = Long.parseLong(idParam);
        Post post = postDAO.getPostById(id);

        // Check if post exists and user is the author
        if (post != null && post.getAuthor().getId().equals(currentUser.getId())) {
            // Delete associated image if exists
            if (post.getImageUrl() != null) {
                String uploadPath = getServletContext().getRealPath("");
                FileUploadUtil.deleteFile(post.getImageUrl(), uploadPath);
            }

            // Delete the post
            postDAO.deletePost(id);
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }
}