package com.donations.dao;

import com.donations.model.Post;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class PostDAO {

    public void savePost(Post post) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(post);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void updatePost(Post post) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(post);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void deletePost(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Post post = session.get(Post.class, id);
            if (post != null) {
                session.delete(post);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public Post getPostById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Post.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Post> getAllPosts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Post> query = session.createQuery(
                    "FROM Post p ORDER BY p.createdAt DESC", Post.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Post> getPostsByCategory(String category) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Post> query = session.createQuery(
                    "FROM Post WHERE category = :category ORDER BY createdAt DESC", Post.class);
            query.setParameter("category", category);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Post> getPostsByAuthor(Long authorId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Post> query = session.createQuery(
                    "FROM Post WHERE author.id = :authorId ORDER BY createdAt DESC", Post.class);
            query.setParameter("authorId", authorId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Post> searchPosts(String keyword) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Post> query = session.createQuery(
                    "FROM Post WHERE LOWER(title) LIKE :keyword OR LOWER(description) LIKE :keyword ORDER BY createdAt DESC",
                    Post.class);
            query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}