<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password - JobPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #11998e, #38ef7d); min-height: 100vh; }
        .card { background: rgba(255,255,255,0.95); border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card p-5">
                <h2 class="text-center mb-4">Change Password</h2>
                
                <% String msg = request.getParameter("msg"); %>
                <% if (msg != null) { %>
                    <div class="alert alert-success"><%= msg %></div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Current Password</label>
                        <input type="password" name="current" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">New Password</label>
                        <input type="password" name="newpass" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirm New Password</label>
                        <input type="password" name="confirm" class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success btn-lg px-5">Update Password</button>
                        <a href="seeker_dashboard.jsp" class="btn btn-secondary btn-lg px-5">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp"%>
</body>
</html>