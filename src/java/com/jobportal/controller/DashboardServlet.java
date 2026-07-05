package com.jobportal.controller;

import com.jobportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if ("seeker".equals(user.getRole())) {
            response.sendRedirect("seeker/jobs.jsp");
        } else {
            response.sendRedirect("recruiter/dashboard.jsp");
        }
    }
}