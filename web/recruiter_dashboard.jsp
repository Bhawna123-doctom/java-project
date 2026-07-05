<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null || !"recruiter".equals(((com.jobportal.model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    String name = ((com.jobportal.model.User)session.getAttribute("user")).getName();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-primary text-white text-center p-5">
    <div class="container">
        <h1 class="display-3 fw-bold">Welcome, <%= name %>!</h1>
        <h2>You are logged in as RECRUITER</h2>
        <hr class="bg-white">
        <p class="lead">Your dashboard is working perfectly!</p>
        <a href="logout" class="btn btn-danger btn-lg mt-4">Logout</a>
    </div>
</body>
</html>