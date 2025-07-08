package com.jobfair;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

@MultipartConfig(fileSizeThreshold=1024*1024*2, maxFileSize=1024*1024*10)
public class UploadResumeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("user");

        Part filePart = request.getPart("resume");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET resume = ? WHERE email = ?");
            ps.setString(1, "uploads/" + fileName);
            ps.setString(2, email);
            int i = ps.executeUpdate();
            PrintWriter out = response.getWriter();
            if (i > 0) {
                out.println("Resume uploaded successfully! <a href='dashboard.jsp'>Go to Dashboard</a>");
            } else {
                out.println("Failed to upload.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
