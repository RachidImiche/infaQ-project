package com.donations.controller;

import com.donations.dao.CommentDAO;
import com.donations.dao.DonationDAO;
import com.donations.dao.LikeDAO;
import com.donations.dao.PostDAO;
import com.donations.model.Comment;
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
import java.util.List;

@WebServlet("/posts/details")
public class PostDetailsServlet extends HttpServlet {

    private PostDAO postDAO;
    private LikeDAO likeDAO;
    private DonationDAO donationDAO;
    private CommentDAO commentDAO;

    @Override
    public void init() {
        postDAO = new PostDAO();
        likeDAO = new LikeDAO();
        donationDAO = new DonationDAO();
        commentDAO = new CommentDAO();
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

        Long postId = Long.parseLong(idParam);
        Post post = postDAO.getPostById(postId);

        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/feed");
            return;
        }

        // Get additional data
        boolean hasLiked = likeDAO.hasUserLikedPost(currentUser.getId(), postId);
        List<Donation> donations = donationDAO.getDonationsByPost(postId);
        List<Comment> comments = commentDAO.getCommentsByPost(postId);

        request.setAttribute("post", post);
        request.setAttribute("hasLiked", hasLiked);
        request.setAttribute("donations", donations);
        request.setAttribute("comments", comments);

        request.getRequestDispatcher("/views/post-details.jsp").forward(request, response);
    }
}