package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public static boolean postJob(Job job) {
        String sql = "INSERT INTO jobs (title, company, location, salary, description, requirements, posted_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, job.getTitle());
            ps.setString(2, job.getCompany());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getSalary());
            ps.setString(5, job.getDescription());
            ps.setString(6, job.getRequirements());
            ps.setInt(7, job.getPostedBy());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT j.*, u.name as recruiter_name FROM jobs j JOIN users u ON j.posted_by = u.id ORDER BY j.posted_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setSalary(rs.getString("salary"));
                job.setDescription(rs.getString("description"));
                job.setPostedDate(rs.getString("posted_date"));
                jobs.add(job);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }
}