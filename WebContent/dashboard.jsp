<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String role = (String) session.getAttribute("role");
%>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("user") %>!</h2>

    <%
        if ("seeker".equals(role)) {
    %>
        <p><a href="browse_jobs.jsp"> Browse Jobs</a></p>
        <p><a href="upload_resume.jsp"> Upload Resume</a></p>
    <%
        } else if ("company".equals(role)) {
    %>
        <p><a href="post_job.jsp"> Post a Job</a></p>
        <p><a href="view_applicants.jsp"> View Applicants</a></p>
    
        <% } else if ("admin".equals(role)) { %>
            <p><a href="admin_panel.jsp">⚙️ Admin Panel</a></p>
        <% } %>
    %>

    <form action="LogoutServlet" method="post">
        <input type="submit" value="Logout">
    </form>
</body>
</html>
