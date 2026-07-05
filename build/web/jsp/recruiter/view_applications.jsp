<%@page import="com.jobportal.model.Application, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null || !"recruiter".equals(((com.jobportal.model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@include file="../common/header.jsp" %>
    <div class="container mt-4">
        <h2>Job Applications</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Job</th>
                    <th>Seeker</th>
                    <th>Applied On</th>
                    <th>Cover Letter</th>
                    <th>Resume</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Application> apps = (List<Application>) request.getAttribute("applications");
                    if(apps != null) {
                        for(Application a : apps) {
                %>
                <tr>
                    <td><%= a.getJobTitle() %></td>
                    <td><%= a.getSeekerName() %></td>
                    <td><%= a.getAppliedDate() %></td>
                    <td><%= a.getCoverLetter() != null ? a.getCoverLetter().substring(0, Math.min(50, a.getCoverLetter().length())) + "..." : "No" %></td>
                    <td><a href="../<%= a.getResumePath() %>" target="_blank" class="btn btn-sm btn-info">View Resume</a></td>
                    <td><span class="badge bg-<%= a.getStatus().equals("accepted") ? "success" : a.getStatus().equals("rejected") ? "danger" : "warning" %>">
                        <%= a.getStatus() %></span></td>
                    <td>
                        <a href="../updatestatus?appid=<%= a.getId() %>&status=accepted" class="btn btn-sm btn-success">Accept</a>
                        <a href="../updatestatus?appid=<%= a.getId() %>&status=rejected" class="btn btn-sm btn-danger">Reject</a>
                    </td>
                </tr>
                <% }} else { %>
                <tr><td colspan="7" class="text-center">No applications yet</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>