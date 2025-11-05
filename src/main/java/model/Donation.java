package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Donation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private LocalDateTime donationDate;
    @Column(nullable = false)
    private long amount;

    /** relation:
     * many donation to one post
     * many donation to one donater
     * many donation to one receiver
     */
    @ManyToOne
    @JoinColumn(name = "donator_id")
    private User donater;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private User receiver;

    @ManyToOne
    @JoinColumn(name = "post_id")
    private Post post;

    // constructors:
    public Donation() {}
    public Donation(LocalDateTime donationDate, long amount, User donater, User receiver) {
        this.donationDate = donationDate;
        this.amount = amount;
        this.donater = donater;
        this.receiver = receiver;
    }

    // setters:
    public void setDonationDate(LocalDateTime donationDate) {
        this.donationDate = donationDate;
    }
    public void setAmount(long amount) {
        this.amount = amount;
    }
    public void setDonater(User donater) {
        this.donater = donater;
    }
    public void setReceiver(User receiver) {
        this.receiver = receiver;
    }
    public void setPost(Post post) {
        this.post = post;
    }

    // getters:
    public Long getId() {
        return id;
    }
    public long getAmount() {
        return amount;
    }
    public User getDonater() {
        return donater;
    }
    public User getReceiver() {
        return receiver;
    }
    public LocalDateTime getDonationDate() {
        return donationDate;
    }
    public Post getPost() {
        return post;
    }
    //DB interacton:

}
