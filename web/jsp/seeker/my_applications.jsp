
```jsp
<%@page import="java.sql.*"%>
<%@include file="/common/header.jsp"%>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Applications</h2>
    
    <table class="table table-hover table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Job Title</th>
                <th>Company</th>
                <th>Applied Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
<%
    int seekerId = (Integer) session.getAttribute("userId");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_jobportal","root","root");
    // YE PURA BLOCK REPLACE KAR DO
PreparedStatement ps = con.prepareStatement(
    "SELECT a.*, j.title, j.location, j.salary, j.job_type " +
    "FROM applications a " +
    "JOIN jobs j ON a.job_id = j.id " +
    "WHERE a.seeker_id = ? " +
    "ORDER BY a.applied_date DESC"
);
ps.setInt(1, seekerId);
ResultSet rs = ps.executeQuery();
    
    while(rs.next()) {
%>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("company") %></td>
            <td><%= rs.getDate("applied_date") %></td>
            <td>
                <span class="badge <%= rs.getString("status").equals("Applied") ? "bg-warning" : 
                                      rs.getString("status").equals("Shortlisted") ? "bg-info" :
                                      rs.getString("status").equals("Rejected") ? "bg-danger" : "bg-success" %>">
                    <%= rs.getString("status") %>
                </span>
            </td>
            <td><a href="job_details.jsp?id=<%= rs.getInt("job_id") %>" class="btn btn-sm btn-outline-primary">View Job</a></td>
        </tr>
<%
    }
    rs.close(); ps.close(); con.close();
%>
        </tbody>
    </table>
</div>
<%@include file="/common/footer.jsp"%>