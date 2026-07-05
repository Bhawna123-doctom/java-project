<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account - Online Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            border-bottom: none;
        }
        .btn-success {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            border: none;
            border-radius: 50px;
            padding: 12px;
            font-weight: bold;
        }
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body class="d-flex align-items-center">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">

                <div class="card shadow-lg">
                    <div class="card-header text-white text-center py-4">
                        <h2 class="mb-0"><i class="fas fa-user-plus"></i> Create Account</h2>
                    </div>
                    
                    <div class="card-body p-5">

                        <!-- SUCCESS / ERROR MESSAGES -->
                        <%
                            String error = request.getParameter("error");
                            String msg = request.getParameter("msg");
                            
                            if (error != null) {
                        %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <strong>Error!</strong> <%= error %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <%
                            } else if (msg != null) {
                        %>
                            <div class="alert alert-success alert-dismissible fade show">
                                <strong>Success!</strong> <%= msg %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>

                        <form action="register" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-bold"><i class="fas fa-user"></i> Full Name</label>
                                <input type="text" name="name" class="form-control form-control-lg" 
                                       placeholder="Enter your full name" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold"><i class="fas fa-envelope"></i> Email</label>
                                <input type="email" name="email" class="form-control form-control-lg" 
                                       placeholder="example@gmail.com" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold"><i class="fas fa-lock"></i> Password</label>
                                <input type="password" name="password" class="form-control form-control-lg" 
                                       placeholder="Create a strong password" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold"><i class="fas fa-phone"></i> Phone Number</label>
                                <input type="text" name="phone" class="form-control form-control-lg" 
                                       placeholder="10-digit mobile number" required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold"><i class="fas fa-user-tag"></i> I am a</label>
                                <select name="role" class="form-select form-select-lg" required>
                                    <option value="">-- Select Role --</option>
                                    <option value="seeker">Job Seeker</option>
                                    <option value="employer">Recruiter / Employer</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-success btn-lg w-100">
                                <i class="fas fa-user-check"></i> Register Now
                            </button>
                        </form>

                        <div class="text-center mt-4">
                            <p class="text-muted">
                                Already have an account? 
                                <a href="login.jsp" class="fw-bold text-decoration-none text-success">
                                    Login Here <i class="fas fa-arrow-right"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="text-center text-white mt-3">
                    <p>&copy; 2025 Online Job Portal | Made with <i class="fas fa-heart text-danger"></i> by Bhanu Kharat</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>