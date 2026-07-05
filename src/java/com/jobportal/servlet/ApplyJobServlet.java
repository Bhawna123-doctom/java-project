package com.jobportal.servlet;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@MultipartConfig(maxFileSize = 16177215) // 16MB
@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int seekerId = (Integer) session.getAttribute("userId");
        int jobId = Integer.parseInt(request.getParameter("job_id"));
        String coverLetter = request.getParameter("cover_letter");

        Part filePart = request.getPart("resume");
        String fileName = getSubmittedFileName(filePart);
        String resumePath = "resumes/" + seekerId + "_" + jobId + "_" + fileName;

        // Create resumes folder if not exists
        String savePath = getServletContext().getRealPath("") + File.separator + "resumes";
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        // Save the file
        filePart.write(savePath + File.separator + seekerId + "_" + jobId + "_" + fileName);

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_jobportal", "root", "root"); // password daal dena agar hai

            String sql = "INSERT INTO applications (job_id, seeker_id, resume_path, cover_letter) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, jobId);
            ps.setInt(2, seekerId);
            ps.setString(3, resumePath);
            ps.setString(4, coverLetter == null ? "" : coverLetter);

            int row = ps.executeUpdate();
            if (row > 0) {
                response.sendRedirect("job_details.jsp?id=" + jobId + "&msg=applied");
            } else {
                response.sendRedirect("job_details.jsp?id=" + jobId + "&error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("job_details.jsp?id=" + jobId + "&error=" + e.getMessage());
        } finally {
            try { if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception e) {}
        }
    }

    private String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String content : header.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "resume.pdf";
    }
}