<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = com.jobfair.DBConnection.getConnection();
%>
<html>
<head><title>Admin Panel</title></head>
<body>
    <h2>Admin Panel</h2>

    <h3>👤 All Users</h3>
    <table border="1">
        <tr><th>Name</th><th>Email</th><th>Role</th></tr>
        <%
            Statement userStmt = conn.createStatement();
            ResultSet users = userStmt.executeQuery("SELECT * FROM users");
            while (users.next()) {
        %>
        <tr>
            <td><%= users.getString("name") %></td>
            <td><%= users.getString("email") %></td>
            <td><%= users.getString("role") %></td>
        </tr>
        <% } %>
    </table>

    <h3>📌 All Jobs</h3>
    <table border="1">
        <tr><th>Title</th><th>Company</th></tr>
        <%
            Statement jobStmt = conn.createStatement();
            ResultSet jobs = jobStmt.executeQuery("SELECT * FROM jobs");
            while (jobs.next()) {
        %>
        <tr>
            <td><%= jobs.getString("title") %></td>
            <td><%= jobs.getString("company") %></td>
        </tr>
        <% } %>
    </table>

    <h3>📋 All Applications</h3>
    <table border="1">
        <tr><th>Job ID</th><th>Seeker Email</th><th>Applied On</th></tr>
        <%
            Statement appStmt = conn.createStatement();
            ResultSet apps = appStmt.executeQuery("SELECT * FROM applications");
            while (apps.next()) {
        %>
        <tr>
            <td><%= apps.getInt("job_id") %></td>
            <td><%= apps.getString("seeker_email") %></td>
            <td><%= apps.getTimestamp("applied_on") %></td>
        </tr>
        <% } %>
    </table>

    <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
