<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"company".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Post Job</title></head>
<body>
    <h2>Post a New Job</h2>
    <form action="PostJobServlet" method="post">
        <input type="text" name="title" placeholder="Job Title" required><br>
        <textarea name="description" placeholder="Job Description" required></textarea><br>
        <input type="submit" value="Post Job">
    </form>
    <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
