<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<%@page import="java.sql.*"%>

<%

    String email = "";
    String phone = "";
    String skills = "";
    String experience = "";
    String education = "";

    Integer userIdObj = (Integer) session.getAttribute("userId");
    if (userIdObj == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    int seekerId = userIdObj;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/online_jobportal", "root", "root");

        PreparedStatement ps = con.prepareStatement(
            "SELECT name, email, phone, skills, experience, education FROM users WHERE id = ?");
        ps.setInt(1, seekerId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            fullName   = rs.getString("name") != null ? rs.getString("name").trim() : fullName;
            email      = rs.getString("email") != null ? rs.getString("email").trim() : "";
            phone      = rs.getString("phone") != null ? rs.getString("phone").trim() : "";
            skills     = rs.getString("skills") != null ? rs.getString("skills").trim() : "";
            experience = rs.getString("experience") != null ? rs.getString("experience").trim() : "";
            education  = rs.getString("education") != null ? rs.getString("education").trim() : "";
        }
        con.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-warning text-center'>Debug: " + e.getMessage() + "</div>");
    }
%>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-header bg-gradient text-white text-center py-4"
                     style="background: linear-gradient(135deg, #11998e, #38ef7d);">
                    <h2 class="mb-0 fw-bold">Update Profile</h2>
                </div>

                <div class="card-body p-5">

                    <!-- Success / Error Messages -->
                    <%
                        String success = (String) session.getAttribute("success");
                        String error = (String) session.getAttribute("error");

                        if (success != null) {
                    %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <strong>Success!</strong> <%= success %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <%
                            session.removeAttribute("success");
                        }
                        if (error != null) {
                    %>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <strong>Error!</strong> <%= error %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <%
                            session.removeAttribute("error");
                        }
                    %>

                    <form action="<%= request.getContextPath() %>/UpdateProfileServlet" method="post">
                        <div class="row g-4">

                            <!-- Full Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Full Name</label>
                                <input type="text" name="fullName" value="<%= fullName %>"
                                       class="form-control form-control-lg" required>
                            </div>

                            <!-- Email (readonly + hidden field to prevent null error) -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" value="<%= email %>"
                                       class="form-control form-control-lg" readonly>
                                <!-- THIS IS THE MOST IMPORTANT LINE - FIXES NULL ERROR FOREVER -->
                                <input type="hidden" name="email" value="<%= email %>">
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Phone</label>
                                <input type="text" name="phone" value="<%= phone %>"
                                       class="form-control form-control-lg" required>
                            </div>

                            <!-- Skills -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Skills</label>
                                <input type="text" name="skills" value="<%= skills %>"
                                       class="form-control form-control-lg"
                                       placeholder="Java, MySQL, HTML, CSS, JavaScript, Spring Boot">
                            </div>

                            <!-- Experience -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Experience (years)</label>
                                <input type="number" name="experience" value="<%= experience %>"
                                       class="form-control form-control-lg" min="0" max="50">
                            </div>

                            <!-- Education -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Education</label>
                                <input type="text" name="education" value="<%= education %>"
                                       class="form-control form-control-lg"
                                       placeholder="B.Tech in Computer Science, MCA, etc." required>
                            </div>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-success btn-lg px-5 fw-bold shadow">
                                Update Profile
                            </button>
                            <a href="seeker_dashboard.jsp" class="btn btn-secondary btn-lg px-5 fw-bold shadow ms-3">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/common/footer.jsp"%>