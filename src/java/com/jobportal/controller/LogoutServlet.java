package com.jobportal.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")  // ya /LogoutServlet bhi chalega
public class LogoutServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // session pura khatam
        }

        // YE LINE CHANGE KAR DE — AB 404 KABHI NAHI AAYEGA
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Logged out successfully");
    }

    // POST bhi handle kar lo (safety ke liye)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}