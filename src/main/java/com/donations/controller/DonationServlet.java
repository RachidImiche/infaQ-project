package com.donations.controller;

import com.donations.dao.DonationDAO;
import com.donations.dao.PostDAO;
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

@WebServlet("/posts/donate")
public class DonationServlet extends HttpServlet {

    private DonationDAO donationDAO;
    private PostDAO postDAO;

    @Override
    public void init() {
        donationDAO = new DonationDAO();
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
        String amountParam = request.getParameter("amount");
        String message = request.getParameter("message");
        String anonymousParam = request.getParameter("anonymous");

        if (postIdParam == null || amountParam == null || amountParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        Long postId = Long.parseLong(postIdParam);
        BigDecimal amount = new BigDecimal(amountParam);
        boolean isAnonymous = "on".equals(anonymousParam);

        Post post = postDAO.getPostById(postId);
        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        // Create donation
        Donation donation = new Donation(currentUser, post, amount, message, isAnonymous);
        donationDAO.saveDonation(donation);

        // Update post's collected amount
        BigDecimal newCollectedAmount = post.getCollectedAmount().add(amount);
        post.setCollectedAmount(newCollectedAmount);
        postDAO.updatePost(post);

        response.sendRedirect(request.getContextPath() + "/posts/details?id=" + postId);
    }
}