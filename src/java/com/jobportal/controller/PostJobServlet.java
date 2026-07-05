package com.jobportal.controller;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import com.jobportal.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/postjob")
public class PostJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"recruiter".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        Job job = new Job();
        job.setTitle(request.getParameter("title"));
        job.setCompany(request.getParameter("company"));
        job.setLocation(request.getParameter("location"));
        job.setSalary(request.getParameter("salary"));
        job.setDescription(request.getParameter("description"));
        job.setRequirements(request.getParameter("requirements"));
        job.setPostedBy(user.getId());

        if (JobDAO.postJob(job)) {
            response.sendRedirect("recruiter/dashboard.jsp?msg=Job posted successfully!");
        } else {
            response.sendRedirect("recruiter/postjob.jsp?error=Failed to post job");
        }
    }
}