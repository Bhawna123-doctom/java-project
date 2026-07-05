<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Job Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts - Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #11998e, #38ef7d);
            min-height: 100vh;
            margin: 0;
        }
        .navbar {
            background: rgba(0,0,0,0.85) !important;
            backdrop-filter: blur(12px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: #38ef7d !important;
        }
        .nav-link {
            color: white !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            color: #38ef7d !important;
            transform: translateY(-2px);
        }
        .dropdown-item:hover {
            background-color: #38ef7d !important;
            color: white !important;
        }
        .dropdown-menu {
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <%
        String role = (String) session.getAttribute("role");
        String fullName = (String) session.getAttribute("fullName");
        if (fullName == null || fullName.trim().isEmpty()) fullName = "User";
        String contextPath = request.getContextPath();
    %>

    <!-- Fixed Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="<%= contextPath %>/index.jsp">JobPortal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">

                    <!-- Seeker Menu -->
                    <% if ("seeker".equals(role)) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/seeker_dashboard.jsp">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/jsp/seeker/jobs.jsp">Browse Jobs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/jsp/seeker/my_applications.jsp">My Applications</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/jsp/seeker/update_profile.jsp">Profile</a>
                        </li>
                    <% } %>

                    <!-- Recruiter Menu -->
                    <% if ("recruiter".equals(role)) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/recruiter_dashboard.jsp">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/jsp/recruiter/post_job.jsp">Post Job</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= contextPath %>/jsp/recruiter/view_posted_jobs.jsp">My Jobs</a>
                        </li>
                    <% } %>

                    <!-- User Dropdown -->
                    <li class="nav-item dropdown ms-3">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle fa-lg me-2"></i>
                            <%= fullName %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="<%= contextPath %>/jsp/seeker/update_profile.jsp">
                                    <i class="fas fa-user me-2"></i>My Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= contextPath %>/jsp/change_password.jsp">
    <i class="fas fa-lock me-2"></i>Change Password
</a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <!-- YE LINE 100% SAHI HAI AB — /logout pe map kiya hai servlet -->
                                <a class="dropdown-item text-danger" href="<%= contextPath %>/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Padding for fixed navbar -->
    <div style="padding-top: 90px;"></div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>