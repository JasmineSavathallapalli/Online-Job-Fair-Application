<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"company".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String companyEmail = (String) session.getAttribute("user");

    Connection conn = com.jobfair.DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT a.id, u.name, u.email, u.resume, j.title FROM applications a " +
        "JOIN users u ON a.seeker_email = u.email " +
        "JOIN jobs j ON a.job_id = j.id " +
        "WHERE j.company = ?"
    );
    ps.setString(1, companyEmail);
    ResultSet rs = ps.executeQuery();
%>
<html>
<head><title>Applicants for My Jobs</title></head>
<body>
    <h2>Applicants for Your Job Postings</h2>
    <table border="1">
        <tr>
            <th>Job Title</th>
            <th>Applicant Name</th>
            <th>Email</th>
            <th>Resume</th>
        </tr>
    <%
        while (rs.next()) {
            String resumePath = rs.getString("resume");
    %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td>
                <% if (resumePath != null && !resumePath.isEmpty()) { %>
                    <a href="<%= resumePath %>" target="_blank">Download</a>
                <% } else { %>
                    Not Uploaded
                <% } %>
            </td>
        </tr>
    <%
        }
    %>
    </table>
    <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
