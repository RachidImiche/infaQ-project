package model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String title;
    @Column(nullable = false)
    private String description;
    @Column(nullable = false)
    private LocalDateTime createdAt;
    @Column(nullable = false)
    private String location;
    @Column(nullable = false)
    private long targetAmount;
    @Column(nullable = false)
    private long currentAmount;

    /**relation:
     * many post to one user
     * one post to many donnation
     **/
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "post")
    private List<Donation> donationList = new ArrayList<Donation>();

    // constructor:
    public Post() {}
    public Post(String title, String description, LocalDateTime createdAt, String location, int targetAmount, int currentAmount) {
        this.title = title;
        this.description = description;
        this.createdAt = createdAt;
        this.location = location;
        this.targetAmount = targetAmount;
        this.currentAmount = currentAmount;
    }

    // setters:

    public void setTitle(String title) {
        this.title = title;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public void setCurrentAmount(int currentAmount) {
        this.currentAmount = currentAmount;
    }
    public void setTargetAmount(int targetAmount) {
        this.targetAmount = targetAmount;
    }
    public void setDonationList(List<Donation> donationList) {
        this.donationList = donationList;
    }
    public void setUser(User user) {
        this.user = user;
    }

    // getters:
    public Long getId() {
        return id;
    }
    public String getTitle() {
        return title;
    }
    public String getDescription() {
        return description;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public String getLocation() {
        return location;
    }
    public long getTargetAmount() {
        return targetAmount;
    }
    public long getCurrentAmount() {
        return currentAmount;
    }
    public List<Donation> getDonationList() {
        return donationList;
    }
    public User getUser(){
        return user;
    }

    // DB ineraction:


}
