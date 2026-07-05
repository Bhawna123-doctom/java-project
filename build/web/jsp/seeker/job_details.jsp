<%@page import="java.sql.*"%>
<%@include file="/common/header.jsp"%>

<%
    int jobId = Integer.parseInt(request.getParameter("id"));
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_jobportal","root","root");
        
        ps = con.prepareStatement("SELECT j.*, u.full_name as recruiter_name FROM jobs j LEFT JOIN users u ON j.company_id = u.id WHERE j.id = ?");
        ps.setInt(1, jobId);
        rs = ps.executeQuery();
        
        if(rs.next()) {
%>
<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3><%= rs.getString("title") %></h3>
                    <h5><%= rs.getString("company") %></h5>
                </div>
                <div class="card-body">
                    <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                    <p><strong>Salary:</strong> <%= rs.getString("salary") != null ? rs.getString("salary") : "Not disclosed" %></p>
                    <p><strong>Job Type:</strong> <span class="badge bg-success"><%= rs.getString("job_type") %></span></p>
                    <hr>
                    <h5>Job Description</h5>
                    <p><%= rs.getString("description").replace("\n", "<br>") %></p>
                    
                    <div class="mt-4">
                        <%
                            // Check if already applied
                            int seekerId = (Integer) session.getAttribute("userId");
                            PreparedStatement ps2 = con.prepareStatement("SELECT * FROM applications WHERE job_id=? AND seeker_id=?");
                            ps2.setInt(1, jobId);
                            ps2.setInt(2, seekerId);
                            ResultSet rs2 = ps2.executeQuery();
                            boolean alreadyApplied = rs2.next();
                            rs2.close();
                            ps2.close();
                        %>
                        <% if(alreadyApplied) { %>
                            <button class="btn btn-secondary btn-lg" disabled>Already Applied</button>
                        <% } else { %>
                            <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal" data-bs-target="#applyModal">
                                Apply Now
                            </button>
                        <% } %>
                        <a href="jobs.jsp" class="btn btn-outline-primary btn-lg ms-3">Back to Jobs</a>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    Posted on <%= rs.getDate("posted_date") %> 
                    <% if(rs.getString("recruiter_name")!=null) { %> | Posted by <%= rs.getString("recruiter_name") %> <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Apply Modal -->
<div class="modal fade" id="applyModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="../ApplyJobServlet" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Apply for <%= rs.getString("title") %></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="job_id" value="<%= jobId %>">
                    <div class="mb-3">
                        <label>Cover Letter (Optional)</label>
                        <textarea name="cover_letter" class="form-control" rows="5" placeholder="Why should we hire you?"></textarea>
                    </div>
                    <div class="mb-3">
                        <label>Upload Resume (PDF only)</label>
                        <input type="file" name="resume" class="form-control" accept=".pdf" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Submit Application</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { rs.close(); ps.close(); con.close(); } catch(Exception e) {}
    }
%>
<%@include file="/common/footer.jsp"%>