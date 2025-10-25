package dao;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String city;
    private boolean verified;
    private String phone;

    public User(String name, String email, String password, String role, String city, boolean verified, String phone) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.city =  city;
        this.role = role;
    }

}
