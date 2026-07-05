package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserDAO.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("fullName", user.getName());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            session.setAttribute("user", user);

            // PERFECT REDIRECT WITH CONTEXT PATH — YE KABHI FAIL NAHI HOGA
            String contextPath = request.getContextPath();

            if ("seeker".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(contextPath + "/seeker_dashboard.jsp");
            }
            else if ("recruiter".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(contextPath + "/recruiter_dashboard.jsp");
            }
            else {
                // Agar role kuch aur ho (admin ya future role)
                response.sendRedirect(contextPath + "/index.jsp");
            }
        } 
        else {
            // Login fail
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid email or password");
        }
    }

    // Optional: GET request bhi handle kar lo (agar direct URL se aaye)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}