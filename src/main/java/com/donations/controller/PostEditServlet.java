package com.donations.controller;

import com.donations.dao.PostDAO;
import com.donations.model.Post;
import com.donations.model.User;
import com.donations.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/posts/edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB
        maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class PostEditServlet extends HttpServlet {

    private PostDAO postDAO;

    @Override
    public void init() {
        postDAO = new PostDAO();
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
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Long id = Long.parseLong(idParam);
        Post post = postDAO.getPostById(id);

        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        // Check if user is the author
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        request.setAttribute("post", post);
        request.getRequestDispatcher("/views/post-edit.jsp").forward(request, response);
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
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String goalAmountStr = request.getParameter("goalAmount");
        String category = request.getParameter("category");
        String removeImage = request.getParameter("removeImage");
        Part imagePart = request.getPart("image");

        Long id = Long.parseLong(idParam);
        Post post = postDAO.getPostById(id);

        if (post == null || !post.getAuthor().getId().equals(currentUser.getId())) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        // Update post fields
        post.setTitle(title);
        post.setDescription(description);
        post.setGoalAmount(new BigDecimal(goalAmountStr));
        post.setCategory(category);

        // Handle image removal
        if ("true".equals(removeImage) && post.getImageUrl() != null) {
            String uploadPath = getServletContext().getRealPath("");
            FileUploadUtil.deleteFile(post.getImageUrl(), uploadPath);
            post.setImageUrl(null);
        }

        // Handle new image upload
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                // Delete old image if exists
                if (post.getImageUrl() != null) {
                    String uploadPath = getServletContext().getRealPath("");
                    FileUploadUtil.deleteFile(post.getImageUrl(), uploadPath);
                }

                // Upload new image
                String uploadPath = getServletContext().getRealPath("");
                String imageUrl = FileUploadUtil.saveFile(imagePart, uploadPath);
                post.setImageUrl(imageUrl);
            } catch (IOException e) {
                request.setAttribute("error", e.getMessage());
                request.setAttribute("post", post);
                request.getRequestDispatcher("/views/post-edit.jsp").forward(request, response);
                return;
            }
        }

        postDAO.updatePost(post);
        response.sendRedirect(request.getContextPath() + "/posts/details?id=" + id);
    }
}