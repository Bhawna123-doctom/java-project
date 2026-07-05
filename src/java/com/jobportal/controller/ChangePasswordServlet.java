package com.jobportal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String current = request.getParameter("current");
        String newpass = request.getParameter("newpass");
        String confirm = request.getParameter("confirm");

        if (!newpass.equals(confirm)) {
            response.sendRedirect(request.getContextPath() + "/jsp/change_password.jsp?error=New passwords do not match");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_jobportal", "root", "root");

            // Pehle current password check karo
            PreparedStatement ps1 = con.prepareStatement("SELECT password FROM users WHERE id = ?");
            ps1.setInt(1, userId);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (!dbPass.equals(current)) {
                    response.sendRedirect(request.getContextPath() + "/jsp/change_password.jsp?error=Current password is incorrect");
                    return;
                }
            }

            // Password update kar do
            PreparedStatement ps2 = con.prepareStatement("UPDATE users SET password = ? WHERE id = ?");
            ps2.setString(1, newpass);
            ps2.setInt(2, userId);
            ps2.executeUpdate();

            con.close();

            response.sendRedirect(request.getContextPath() + "/jsp/change_password.jsp?msg=Password changed successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/change_password.jsp?error=Something went wrong");
        }
    }
}