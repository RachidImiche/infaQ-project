package com.donations.dao;

import com.donations.model.Like;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class LikeDAO {

    public void saveLike(Like like) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(like);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void deleteLike(Long userId, Long postId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Query query = session.createQuery(
                    "DELETE FROM Like WHERE user.id = :userId AND post.id = :postId");
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

    public Like getLike(Long userId, Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Like> query = session.createQuery(
                    "FROM Like WHERE user.id = :userId AND post.id = :postId", Like.class);
            query.setParameter("userId", userId);
            query.setParameter("postId", postId);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean hasUserLikedPost(Long userId, Long postId) {
        return getLike(userId, postId) != null;
    }

    public int getLikesCount(Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(l) FROM Like l WHERE l.post.id = :postId", Long.class);
            query.setParameter("postId", postId);
            return query.uniqueResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}