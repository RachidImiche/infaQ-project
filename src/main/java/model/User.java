package dao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class User {
    @Id
    private long id;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String email;
    @Column(nullable = false)
    private String phone;
    @Column(nullable = false)
    private String password;
    @Column(nullable = false)
    private String role;
    @Column(nullable = false)
    private String city;
    @Column(nullable = false)
    private boolean verified;

    public User(String name, String email, String password, String role, String city, boolean verified, String phone) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.city =  city;
        this.role = role;
    }

    // setters:
    public void setId(long id) {
        this.id = id;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    //getters:
    public long getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getEmail() {
        return email;
    }
    public String getPhone(){ return phone; }
    public String getPassword() {
        return password;
    }
    public String getRole() {
        return role;
    }
    public String getCity() {
        return city;
    }
    public boolean isVerified() {
        return verified;
    }
}
