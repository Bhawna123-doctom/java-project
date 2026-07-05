package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRole(role);

        // Pehle check karo email already exist toh nahi
        if (UserDAO.isEmailExists(email)) {
            response.sendRedirect("register.jsp?error=Email already exists! Please use another email.");
            return;
        }

        // Ab register karo
        boolean success = UserDAO.register(user);

        if (success) {
            response.sendRedirect("login.jsp?msg=Registration successful! Please login now.");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed! Try again later.");
        }
    }
}