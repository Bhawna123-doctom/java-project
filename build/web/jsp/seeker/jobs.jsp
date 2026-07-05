<%@page import="com.jobportal.dao.JobDAO, com.jobportal.model.Job, java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    com.jobportal.model.User user = (com.jobportal.model.User) session.getAttribute("user");
    if (user == null || !"seeker".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Jobs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark bg-primary p-3">
        <div class="container-fluid">
            <span class="navbar-brand">JobPortal - <%= user.getName() %> (Job Seeker)</span>
            <!-- LOGOUT BUTTON PURA HATA DIYA GAYA HAI -->
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-primary mb-4">Available Jobs</h2>
        <div class="row">
            <%
                List<Job> jobs = JobDAO.getAllJobs();
                if (jobs == null || jobs.isEmpty()) {
            %>
                <div class="col-12">
                    <div class="alert alert-info text-center p-4">
                        No jobs posted yet!
                    </div>
                </div>
            <%
                } else {
                    for (Job job : jobs) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="card shadow h-100 hover-shadow">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title text-success"><%= job.getTitle() %></h5>
                            <p class="mb-1"><strong>Company:</strong> <%= job.getCompany() %></p>
                            <p class="mb-1"><strong>Location:</strong> <%= job.getLocation() != null ? job.getLocation() : "Remote" %></p>
                            <p class="mb-3"><strong>Salary:</strong> <%= job.getSalary() != null ? job.getSalary() : "Negotiable" %></p>
                            <p class="text-muted small flex-grow-1">
                                <%= job.getDescription().length() > 100 ? 
                                    job.getDescription().substring(0, 100) + "..." : 
                                    job.getDescription() %>
                            </p>
                            <a href="apply.jsp?jobid=<%= job.getId() %>" 
                               class="btn btn-success mt-auto">Apply Now</a>
                        </div>
                    </div>
                </div>
            <% 
                    }
                } 
            %>
        </div>
    </div>
</body>
</html>