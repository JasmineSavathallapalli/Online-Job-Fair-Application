<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"seeker".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Upload Resume</title></head>
<body>
    <h2>Upload Your Resume (PDF or DOCX)</h2>
    <form action="UploadResumeServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="resume" accept=".pdf,.docx" required><br><br>
        <button type="submit">Upload</button>
    </form>
    <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
