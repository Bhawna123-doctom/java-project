package com.jobportal.dao;

import com.jobportal.model.User;
import com.jobportal.util.DBConnection;
import java.sql.*;

public class UserDAO {

    // 1. CHECK IF EMAIL ALREADY EXISTS
    public static boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. REGISTER NEW USER
    public static boolean register(User user) {
        // Check duplicate email
        if (isEmailExists(user.getEmail())) {
            System.out.println("BLOCKED: Email already exists → " + user.getEmail());
            return false;
        }

        String sql = "INSERT INTO users (name, email, password, role, phone) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) {
                System.out.println("ERROR: Database connection failed!");
                return false;
            }

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getPhone());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("SUCCESS: New user registered → " + user.getEmail());
                return true;
            } else {
                System.out.println("FAILED: No rows inserted");
                return false;
            }

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.getMessage());
            if (e.getErrorCode() == 1062) {
                System.out.println("Duplicate email blocked");
            }
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. LOGIN USER
    public static User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) {
                System.out.println("LOGIN FAILED: No DB Connection");
                return null;
            }

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (password.equals(dbPassword)) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));

                    System.out.println("LOGIN SUCCESS: " + email + " (" + user.getRole() + ")");
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("LOGIN FAILED: Wrong credentials");
        return null;
    }
}