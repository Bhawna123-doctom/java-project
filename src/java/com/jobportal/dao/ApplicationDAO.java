package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public static boolean applyJob(int jobId, int seekerId, String resumePath, String coverLetter) {
        String sql = "INSERT INTO applications (job_id, seeker_id, resume_path, cover_letter) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, seekerId);
            ps.setString(3, resumePath);
            ps.setString(4, coverLetter);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Application> getApplicationsByRecruiter(int recruiterId) {
        List<Application> apps = new ArrayList<>();
        String sql = """
            SELECT a.*, j.title as job_title, u.name as seeker_name 
            FROM applications a 
            JOIN jobs j ON a.job_id = j.id 
            JOIN users u ON a.seeker_id = u.id 
            WHERE j.posted_by = ? 
            ORDER BY a.applied_date DESC
            """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setJobId(rs.getInt("job_id"));
                app.setJobTitle(rs.getString("job_title"));
                app.setSeekerId(rs.getInt("seeker_id"));
                app.setSeekerName(rs.getString("seeker_name"));
                app.setResumePath(rs.getString("resume_path"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getString("applied_date"));
                apps.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return apps;
    }

    public static boolean updateStatus(int appId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, appId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}