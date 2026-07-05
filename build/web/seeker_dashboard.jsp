<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seeker Dashboard - JobPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #11998e, #38ef7d);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .welcome-text {
            text-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .dashboard-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 25px;
            backdrop-filter: blur(15px);
            transition: all 0.4s ease;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            height: 100%;
        }
        .dashboard-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }
        .icon-large {
            font-size: 3.5rem;
            margin-bottom: 20px;
        }
        .btn-custom {
            border-radius: 50px;
            padding: 12px 40px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .logout-btn {
            border-radius: 50px;
            padding: 15px 50px;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<div class="container py-5">

    <!-- Welcome Message -->
    <div class="text-center mb-5">
        <h1 class="display-3 text-white fw-bold welcome-text">
            Welcome, <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Job Seeker" %>!
        </h1>
        <p class="lead text-white opacity-90 mt-3">
            You are logged in as <strong class="text-warning">JOB SEEKER</strong>
        </p>
        <hr class="bg-white opacity-50 w-25 mx-auto">
    </div>

    <!-- Dashboard Cards -->
    <div class="row g-5 justify-content-center">

        <!-- Browse Jobs -->
        <div class="col-lg-4 col-md-6">
            <div class="card dashboard-card border-0 text-center p-5">
                <div class="card-body">
                    <i class="fas fa-search-dollar icon-large text-primary"></i>
                    <h3 class="card-title mb-3">Browse Jobs</h3>
                    <p class="text-muted mb-4">Search and apply to latest job openings</p>
                    <a href="${pageContext.request.contextPath}/jsp/seeker/jobs.jsp" 
                       class="btn btn-primary btn-custom shadow-lg">
                        View All Jobs
                    </a>
                </div>
            </div>
        </div>

        <!-- My Applications -->
        <div class="col-lg-4 col-md-6">
            <div class="card dashboard-card border-0 text-center p-5">
                <div class="card-body">
                    <i class="fas fa-file-alt icon-large text-success"></i>
                    <h3 class="card-title mb-3">My Applications</h3>
                    <p class="text-muted mb-4">Track status of your applied jobs</p>
                    <a href="${pageContext.request.contextPath}/jsp/seeker/my_applications.jsp" 
                       class="btn btn-success btn-custom shadow-lg">
                        <i class="fas fa-list-alt me-2"></i> View Applications
                    </a>
                </div>
            </div>
        </div>

        <!-- Update Profile -->
        <div class="col-lg-4 col-md-6">
            <div class="card dashboard-card border-0 text-center p-5">
                <div class="card-body">
                    <i class="fas fa-user-edit icon-large text-info"></i>
                    <h3 class="card-title mb-3">Update Profile</h3>
                    <p class="text-muted mb-4">Keep your resume & skills updated</p>
                    <a href="${pageContext.request.contextPath}/jsp/seeker/update_profile.jsp" 
                       class="btn btn-info btn-custom shadow-lg text-white">
                        <i class="fas fa-edit me-2"></i> Edit Profile
                    </a>
                </div>
            </div>
        </div>

    </div>

    <!-- Logout Button -->
    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/logout"
   class="btn btn-danger logout-btn shadow-lg">
    <i class="fas fa-sign-out-alt me-3"></i> Logout
</a>
    </div>

</div>

<%@include file="/common/footer.jsp"%>
</body>
</html>