package com.donations.controller;

import com.donations.dao.DonationDAO;
import com.donations.dao.PostDAO;
import com.donations.dao.UserDAO;
import com.donations.model.Donation;
import com.donations.model.Post;
import com.donations.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;
    private PostDAO postDAO;
    private DonationDAO donationDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        postDAO = new PostDAO();
        donationDAO = new DonationDAO();
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
        String usernameParam = request.getParameter("username");

        User profileUser;
        boolean isOwnProfile;

        if (usernameParam != null && !usernameParam.trim().isEmpty()) {
            // View another user's profile
            profileUser = userDAO.getUserByUsername(usernameParam);
            if (profileUser == null) {
                response.sendRedirect(request.getContextPath() + "/feed");
                return;
            }
            isOwnProfile = profileUser.getId().equals(currentUser.getId());
        } else {
            // View own profile
            profileUser = currentUser;
            isOwnProfile = true;
        }

        // Get user's posts
        List<Post> userPosts = postDAO.getPostsByAuthor(profileUser.getId());

        // Get user's donations (only if viewing own profile)
        List<Donation> userDonations = null;
        if (isOwnProfile) {
            userDonations = donationDAO.getDonationsByUser(profileUser.getId());
        }

        // Calculate statistics
        int totalPosts = userPosts != null ? userPosts.size() : 0;
        BigDecimal totalRaised = BigDecimal.ZERO;
        BigDecimal totalGoal = BigDecimal.ZERO;
        int totalLikes = 0;
        int totalDonationsReceived = 0;

        if (userPosts != null) {
            for (Post post : userPosts) {
                totalRaised = totalRaised.add(post.getCollectedAmount());
                totalGoal = totalGoal.add(post.getGoalAmount());
                totalLikes += post.getLikesCount();
                totalDonationsReceived += post.getDonationsCount();
            }
        }

        BigDecimal totalDonated = BigDecimal.ZERO;
        if (userDonations != null) {
            for (Donation donation : userDonations) {
                totalDonated = totalDonated.add(donation.getAmount());
            }
        }

        request.setAttribute("profileUser", profileUser);
        request.setAttribute("isOwnProfile", isOwnProfile);
        request.setAttribute("userPosts", userPosts);
        request.setAttribute("userDonations", userDonations);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("totalRaised", totalRaised);
        request.setAttribute("totalGoal", totalGoal);
        request.setAttribute("totalLikes", totalLikes);
        request.setAttribute("totalDonationsReceived", totalDonationsReceived);
        request.setAttribute("totalDonated", totalDonated);

        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}