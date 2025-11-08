package com.donations.dao;

import com.donations.model.Donation;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.math.BigDecimal;
import java.util.List;

public class DonationDAO {

    public void saveDonation(Donation donation) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(donation);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<Donation> getDonationsByPost(Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Donation> query = session.createQuery(
                    "FROM Donation WHERE post.id = :postId ORDER BY createdAt DESC", Donation.class);
            query.setParameter("postId", postId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Donation> getDonationsByUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Donation> query = session.createQuery(
                    "FROM Donation WHERE user.id = :userId ORDER BY createdAt DESC", Donation.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public BigDecimal getTotalDonationsForPost(Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<BigDecimal> query = session.createQuery(
                    "SELECT COALESCE(SUM(d.amount), 0) FROM Donation d WHERE d.post.id = :postId", BigDecimal.class);
            query.setParameter("postId", postId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

    public int getDonationsCountForPost(Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(d) FROM Donation d WHERE d.post.id = :postId", Long.class);
            query.setParameter("postId", postId);
            return query.uniqueResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}