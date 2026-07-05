package com.jobportal.model;

public class User {
    private int id;
    private String name, email, password, role, phone;

    // Default constructor (for DAO)
    public User() {}

    // Constructor without id (for registration)
    public User(String name, String email, String password, String role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Constructor with all fields (optional – useful in some cases)
    public User(int id, String name, String email, String password, String role, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.phone = phone;
    }

    // ====== Getters & Setters ======
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    // ====== Bonus: toString() method (debugging ke liye bahut kaam aata hai) ======
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}