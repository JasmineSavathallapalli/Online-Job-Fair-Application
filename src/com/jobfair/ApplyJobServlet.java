package com.jobfair;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ApplyJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("user");
        int jobId = Integer.parseInt(request.getParameter("job_id"));

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO applications (job_id, seeker_email) VALUES (?, ?)");
            ps.setInt(1, jobId);
            ps.setString(2, email);

            int result = ps.executeUpdate();
            PrintWriter out = response.getWriter();
            if (result > 0) {
                EmailSender.send(email, "Job Application Confirmation",
                    "You have successfully applied to Job ID: " + jobId + ". Good luck!");
                out.println("Applied and confirmation sent! <a href='browse_jobs.jsp'>Back</a>");
            }
            else {
                out.println(" Application Failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
