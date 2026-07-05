<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    com.jobportal.model.User user = (com.jobportal.model.User) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Recruiter Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark bg-dark p-3">
        <div class="container-fluid">
            <span class="navbar-brand">Welcome, <%= user.getName() %> (Recruiter)</span>
            <a href="logout" class="btn btn-outline-light">Logout</a>
        </div>
    </nav>
    <div class="container mt-5 text-center">
        <h1>Recruiter Dashboard</h1>
        <a href="postjob.jsp" class="btn btn-primary btn-lg m-3">Post New Job</a>
        <a href="viewapplications.jsp" class="btn btn-info btn-lg m-3">View Applications</a>
    </div>
</body>
</html>