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

@WebServlet("/posts/create")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB
        maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class PostCreateServlet extends HttpServlet {

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

        request.getRequestDispatcher("/views/post-create.jsp").forward(request, response);
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

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String goalAmountStr = request.getParameter("goalAmount");
        String category = request.getParameter("category");
        Part imagePart = request.getPart("image");

        // Validate input
        if (title == null || title.trim().isEmpty() ||
                goalAmountStr == null || goalAmountStr.trim().isEmpty()) {
            request.setAttribute("error", "Title and goal amount are required");
            request.getRequestDispatcher("/views/post-create.jsp").forward(request, response);
            return;
        }

        // Create post
        Post post = new Post();
        post.setTitle(title);
        post.setDescription(description);
        post.setGoalAmount(new BigDecimal(goalAmountStr));
        post.setCollectedAmount(BigDecimal.ZERO);
        post.setCategory(category);
        post.setAuthor(currentUser);

        //  image upload
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                String uploadPath = getServletContext().getRealPath("");
                String imageUrl = FileUploadUtil.saveFile(imagePart, uploadPath);
                post.setImageUrl(imageUrl);
            } catch (IOException e) {
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("/views/post-create.jsp").forward(request, response);
                return;
            }
        }

        postDAO.savePost(post);
        response.sendRedirect(request.getContextPath() + "/feed");
    }
}