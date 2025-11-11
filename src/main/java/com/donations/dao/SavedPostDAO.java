package com.donations.dao;

import com.donations.model.SavedPost;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class SavedPostDAO {

    public void saveSavedPost(SavedPost savedPost) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(savedPost);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void deleteSavedPost(Long userId, Long postId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Query<?> query = session.createQuery(
                    "DELETE FROM SavedPost WHERE user.id = :userId AND post.id = :postId");
            query.setParameter("userId", userId);
            query.setParameter("postId", postId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public SavedPost getSavedPost(Long userId, Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<SavedPost> query = session.createQuery(
                    "FROM SavedPost WHERE user.id = :userId AND post.id = :postId", SavedPost.class);
            query.setParameter("userId", userId);
            query.setParameter("postId", postId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean hasUserSavedPost(Long userId, Long postId) {
        return getSavedPost(userId, postId) != null;
    }

    public List<SavedPost> getSavedPostsByUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<SavedPost> query = session.createQuery(
                    "FROM SavedPost sp WHERE sp.user.id = :userId ORDER BY sp.savedAt DESC", SavedPost.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getSavedPostsCountForUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(sp) FROM SavedPost sp WHERE sp.user.id = :userId", Long.class);
            query.setParameter("userId", userId);
            return query.uniqueResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
