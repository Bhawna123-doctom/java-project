package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.model.Application;
import com.jobportal.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewapplications")
public class ViewApplicationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"recruiter".equals(user.getRole())) {
            response.sendRedirect("../login.jsp");
            return;
        }

        List<Application> applications = ApplicationDAO.getApplicationsByRecruiter(user.getId());
        request.setAttribute("applications", applications);
        RequestDispatcher rd = request.getRequestDispatcher("recruiter/viewapplications.jsp");
        rd.forward(request, response);
    }
}