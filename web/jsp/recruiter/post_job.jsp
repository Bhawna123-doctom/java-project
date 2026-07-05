<!-- seeker/jobs.jsp -->
<%@page import="java.sql.*"%>
<%@include file="/common/header.jsp"%>

<div class="container mt-5">
    <h2 class="text-center mb-4">Available Jobs</h2>

    <!-- Search Form -->
    <form class="row g-3 mb-5">
        <div class="col-md-4">
            <input type="text" name="search" class="form-control" placeholder="Job title or company"
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        </div>
        <div class="col-md-3">
            <input type="text" name="location" class="form-control" placeholder="Location"
                   value="<%= request.getParameter("location") != null ? request.getParameter("location") : "" %>">
        </div>
        <div class="col-md-3">
            <select name="job_type" class="form-select">
                <option value="">All Job Types</option>
                <option value="Full-Time" <%= "Full-Time".equals(request.getParameter("job_type")) ? "selected" : "" %>>Full-Time</option>
                <option value="Part-Time" <%= "Part-Time".equals(request.getParameter("job_type")) ? "selected" : "" %>>Part-Time</option>
                <option value="Internship" <%= "Internship".equals(request.getParameter("job_type")) ? "selected" : "" %>>Internship</option>
                <option value="Remote" <%= "Remote".equals(request.getParameter("job_type")) ? "selected" : "" %>>Remote</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-success w-100">Search</button>
        </div>
    </form>

    <div class="row">
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_jobportal", "root", "root");  // password daal dena agar hai

        String sql = "SELECT j.*, u.full_name as recruiter_name FROM jobs j " +
                     "LEFT JOIN users u ON j.company_id = u.id WHERE 1=1";
        
        String search = request.getParameter("search");
        String location = request.getParameter("location");
        String job_type = request.getParameter("job_type");

        if(search != null && !search.trim().isEmpty()) {
            sql += " AND (j.title LIKE ? OR j.company LIKE ?)";
        }
        if(location != null && !location.trim().isEmpty()) {
            sql += " AND j.location LIKE ?";
        }
        if(job_type != null && !job_type.isEmpty()) {
            sql += " AND j.job_type = ?";
        }

        sql += " ORDER BY j.posted_date DESC";

        ps = con.prepareStatement(sql);

        int idx = 1;
        if(search != null && !search.trim().isEmpty()) {
            String like = "%" + search + "%";
            ps.setString(idx++, like);
            ps.setString(idx++, like);
        }
        if(location != null && !location.trim().isEmpty()) {
            ps.setString(idx++, "%" + location + "%");
        }
        if(job_type != null && !job_type.isEmpty()) {
            ps.setString(idx++, job_type);
        }

        rs = ps.executeQuery();

        while(rs.next()) {
%>
        <div class="col-lg-6 mb-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body">
                    <h4 class="card-title text-primary"><%= rs.getString("title") %></h4>
                    <h6 class="text-muted"><%= rs.getString("company") %></h6>
                    <p class="mb-1"><strong>Location:</strong> <%= rs.getString("location") %></p>
                    <p class="mb-1"><strong>Salary:</strong> <%= rs.getString("salary") != null ? rs.getString("salary") : "Not disclosed" %></p>
                    <p class="mb-2"><strong>Type:</strong> <span class="badge bg-info"><%= rs.getString("job_type") %></span></p>
                    <p class="text-truncate"><%= rs.getString("description").length() > 150 ? rs.getString("description").substring(0,147)+"..." : rs.getString("description") %></p>
                    <a href="job_details.jsp?id=<%= rs.getInt("id") %>" class="btn btn-outline-primary btn-sm">View Details & Apply</a>
                </div>
                <div class="card-footer text-muted small">
                    Posted on: <%= rs.getDate("posted_date") %>
                    <% if(rs.getString("employer_name") != null) { %> | By <%= rs.getString("employer_name") %> <% } %>
                </div>
            </div>
        </div>
<%
        }
        if(!rs.isBeforeFirst()) {
            out.println("<div class='col-12 text-center'><h4>No jobs found</h4></div>");
        }
    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception e) {}
    }
%>
    </div>
</div>

<%@include file="/common/footer.jsp"%>