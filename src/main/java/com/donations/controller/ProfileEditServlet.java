package com.donations.controller;

import com.donations.dao.UserDAO;
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

@WebServlet("/profile/edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB
        maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class ProfileEditServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
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

        // Get fresh user data from database
        User user = userDAO.getUserById(currentUser.getId());
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/profile-edit.jsp").forward(request, response);
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
        User user = userDAO.getUserById(currentUser.getId());

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form data
        String fullName = request.getParameter("fullName");
        String bio = request.getParameter("bio");
        String removeImage = request.getParameter("removeImage");
        Part imagePart = request.getPart("profileImage");

        // Update full name
        if (fullName != null && !fullName.trim().isEmpty()) {
            user.setFullName(fullName.trim());
        }

        // Update bio
        if (bio != null) {
            user.setBio(bio.trim().isEmpty() ? null : bio.trim());
        }

        // Handle image removal
        if ("true".equals(removeImage) && user.getProfileImage() != null) {
            String uploadPath = getServletContext().getRealPath("");
            FileUploadUtil.deleteFile(user.getProfileImage(), uploadPath);
            user.setProfileImage(null);
        }

        // Handle new image upload
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                // Delete old image if exists
                if (user.getProfileImage() != null) {
                    String uploadPath = getServletContext().getRealPath("");
                    FileUploadUtil.deleteFile(user.getProfileImage(), uploadPath);
                }

                // Upload new image
                String uploadPath = getServletContext().getRealPath("");
                String imageUrl = FileUploadUtil.saveFile(imagePart, uploadPath);
                user.setProfileImage(imageUrl);
            } catch (IOException e) {
                request.setAttribute("error", e.getMessage());
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/profile-edit.jsp").forward(request, response);
                return;
            }
        }

        // Update user in database
        userDAO.updateUser(user);

        // Update session
        session.setAttribute("user", user);

        // Redirect to profile
        response.sendRedirect(request.getContextPath() + "/profile?success=true");
    }
}

