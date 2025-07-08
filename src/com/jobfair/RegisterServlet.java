package com.jobfair;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int result = ps.executeUpdate();
            PrintWriter out = response.getWriter();
            if (result > 0) {
                out.println("Registration successful! <a href='login.jsp'>Login now</a>");
            } else {
                out.println("Registration failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
