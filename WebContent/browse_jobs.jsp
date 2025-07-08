<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"seeker".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = com.jobfair.DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs");
    ResultSet rs = ps.executeQuery();
%>
<html>
<head><title>Available Jobs</title></head>
<body>
    <h2>Available Jobs</h2>
    <%
        while (rs.next()) {
    %>
        <div style="border: 1px solid #aaa; margin: 10px; padding: 10px;">
            <h3><%= rs.getString("title") %></h3>
            <p><%= rs.getString("description") %></p>
            <small>Company: <%= rs.getString("company") %></small>
            <form action="ApplyJobServlet" method="post">
                <input type="hidden" name="job_id" value="<%= jobId %>">
                <button type="submit">Apply</button>
            </form>
        </div>
    <%
        }
    %>
    <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
