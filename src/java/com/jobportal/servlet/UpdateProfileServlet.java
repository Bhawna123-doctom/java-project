package com.jobportal.servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userIdObj = (Integer) session.getAttribute("userId");

        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = userIdObj;

        // Form se values le rahe hain — NULL SAFE bana diya hai sabko
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String skills = request.getParameter("skills");
        String experience = request.getParameter("experience");
        String education = request.getParameter("education");

        // EXTRA SAFETY — Agar koi field null ya blank aaye toh purana value ya default daal denge
        if (fullName == null || fullName.trim().isEmpty()) fullName = "User";
        if (email == null || email.trim().isEmpty()) email = "user@example.com"; // fallback (kabhi nahi hoga ab)
        if (phone == null) phone = "";
        if (skills == null) skills = "";
        if (experience == null) experience = "";
        if (education == null) education = "";

        fullName = fullName.trim();
        email = email.trim();
        phone = phone.trim();
        skills = skills.trim();
        experience = experience.trim();
        education = education.trim();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_jobportal", "root", "root");

            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, skills = ?, experience = ?, education = ? WHERE id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, skills);
            ps.setString(5, experience);
            ps.setString(6, education);
            ps.setInt(7, userId);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // Session mein fullName update kar diya — header mein live dikhega
                session.setAttribute("fullName", fullName);

                // Optional: agar email change karna allow karega future mein
                // session.setAttribute("userEmail", email);

                session.setAttribute("success", "Profile updated successfully!");
            } else {
                session.setAttribute("error", "No changes were made or something went wrong.");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Database Error: " + e.getMessage());
        }

        // Redirect back to update profile page with success/error message
        response.sendRedirect(request.getContextPath() + "/jsp/seeker/update_profile.jsp");
    }
}